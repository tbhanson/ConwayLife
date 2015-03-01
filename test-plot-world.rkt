#lang racket

(require rackunit
         "timeLessState.rkt"
         "stringToTimeLessState.rkt"
         "nextState.rkt"
         "plot-world.rkt")

(plot-world
   (make-state (list (make-point 0 0))))

(plot-world
 (strings->state (make-point 0 0) (list "xx" "xx")))


(define (southeastward-glider-at x y)
  (strings->state (make-point x y) (list "x"
                                         " xx"
                                         "xx")))

(plot-world
 (southeastward-glider-at 0 0))

  
