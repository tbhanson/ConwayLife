#lang racket

(require rackunit
         "../src/timeLessState.rkt"
         "../src/stringToTimeLessState.rkt"
         "../src/nextState.rkt")

; a state with a single point yields an empty state
(check-equal?
  (next-world-state
   (make-state (list (make-point 0 0))))
  (make-state '()))

; a state with a two adjacent points also yields an empty state
(check-equal?
  (next-world-state
   (make-state (list (make-point 0 0))))
  (make-state '()))

; a state with a square stays the same
(check-equal?
  (next-world-state
   (strings->state (make-point 0 0) (list "xx" "xx")))
  (strings->state (make-point 0 0) (list "xx" "xx")))

; a state with a "corner" becomes a square
(check-equal?
  (next-world-state
   (strings->state (make-point 0 0) (list "xx" "x")))
  (strings->state (make-point 0 0) (list "xx" "xx")))

; a state with three living cells in a row is a blinker :)
(check-equal?
  (next-world-state
   (strings->state (make-point 0 0) (list "xxx")))
  (strings->state (make-point 1 1) (list "x"
                                         "x"
                                         "x")))

(define (southeastward-glider-at x y)
  (strings->state (make-point x y) (list "x"
                                         " xx"
                                         "xx")))

; a "glider" moves 1 diagonal step in 4 iterations
(check-equal?
  (next-world-state
   (next-world-state
    (next-world-state
     (next-world-state
      (southeastward-glider-at 0 0)))))
  (southeastward-glider-at 1 -1))

  
