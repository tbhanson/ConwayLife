#lang racket

(require rackunit
         "../src/timeLessState.rkt"
         "../src/animateWorldStream.rkt"
         "../src/stringToTimeLessState.rkt"
         )

; to do:
; - get minimal containing bounds (made square? how?) for whole stream we display, so bounds don't change...

(animate-world-state-stream 
 (make-state (list ))
 10 ; max state count
 1) ; seconds each picture

(animate-world-state-stream 
 (make-state (list (make-point 0 0)))
 10 ; max state count
 1) ; seconds each picture

(animate-world-state-stream 
 (strings->state (make-point 0 0) (list "xx" "xx"))
 10 ; max state count
 1) ; seconds each picture


(define (southeastward-glider-at x y)
  (strings->state (make-point x y) 
                  (list "x"
                        " xx"
                        "xx")))

(define (northeastward-glider-at x y)
  (strings->state (make-point x y) 
                  (list "xx"
                        " xx"
                        "x")))

; southeastward glider moves down and to the right every 4 steps
(animate-world-state-stream 
 (southeastward-glider-at 0 0)
 100 ; max state count
 0.25) ; seconds each picture


; these 2 gliders should collide, i figure
(animate-world-state-stream 
 (merge-worlds
  (southeastward-glider-at 0 10)
  (northeastward-glider-at 0 -10))
 100 ; max state count
 0.25) ; seconds each picture

