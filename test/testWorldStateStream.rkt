#lang racket

(require rackunit
         "../src/timeLessState.rkt"
         "../src/worldStateStream.rkt"
         "../src/stringToTimeLessState.rkt"
         )

; --------finite cases------------

; empty world stays the same: stream has length 1
(check-equal?
 (stream-length
  (world-state-stream
   (make-state '())))
  1)

; single point vanishes, then empty-state stays the same: stream has length 2
(check-equal?
 (stream-length
  (world-state-stream
   (make-state (list (make-point 0 0)))))
  2)

; square stays the same: stream has length 1
(check-equal?
 (stream-length
  (world-state-stream
   (strings->state (make-point 0 0) (list "xx" "xx"))))
  1)


; --------infinite cases------------

(define (southeastward-glider-at x y)
  (strings->state (make-point x y) 
                  (list "x"
                        " xx"
                        "xx")))

; southeastward glider moves down and to the right every 4 steps
(check-equal?
 (stream-ref
  (world-state-stream
   (southeastward-glider-at 0 0))
  4)
 (southeastward-glider-at 1 -1))

(check-equal?
 (stream-ref
  (world-state-stream
   (southeastward-glider-at 0 0))
  40)
 (southeastward-glider-at 10 -10))


;--------------------------test stream-total-bounds

(define (northeastward-glider-at x y)
  (strings->state (make-point x y) 
                  (list "xx"
                        " xx"
                        "x")))


; these 2 gliders should collide, i figure
(check-equal?
 (stream-total-bounds
  (world-state-stream
   (merge-worlds
    (southeastward-glider-at 0 10)
    (northeastward-glider-at 0 -10))))
 
 (cons (make-point 0 -12) (make-point 10 10)))

