#lang racket

(require rackunit
         "../src/timeLessState.rkt"
         "../src/animateWorldStream.rkt"
         "../src/stringToTimeLessState.rkt"
         )

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

; southeastward glider moves down and to the right every 4 steps
(animate-world-state-stream 
 (southeastward-glider-at 0 0)
 100 ; max state count
 0.25) ; seconds each picture

