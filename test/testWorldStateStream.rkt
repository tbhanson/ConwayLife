#lang racket

(require rackunit
         "../src/timeLessState.rkt"
         "../src/worldStateStream.rkt"
         "../src/stringToTimeLessState.rkt"
         ;"../src/displayWorld.rkt"
         )

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
