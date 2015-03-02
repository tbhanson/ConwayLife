#lang racket

(require rackunit
         "../src/timeLessState.rkt"
         "../src/stringToTimeLessState.rkt"
         "../src/displayWorld.rkt")

(display-world
   (make-state (list (make-point 0 0))))


(display-world
 (strings->state (make-point 0 0) (list "xx" "xx")))


(define (southeastward-glider-at x y)
  (strings->state (make-point x y) (list "x"
                                         " xx"
                                         "xx")))

(display-world
 (southeastward-glider-at 0 0))

