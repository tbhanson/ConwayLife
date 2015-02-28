#lang racket


(require rackunit
         "timeLessState.rkt"
         "stateBounds.rkt"
         )

(check-equal?
  (state-bounds
   (make-state (list (make-point 0 0) (make-point 1 1))))
  (cons (make-point 0 0) (make-point 1 1)))
  
(check-equal?
  (state-bounds
   (make-state (list (make-point 0 0) (make-point 1 1) (make-point -1 -1))))
  (cons (make-point -1 -1) (make-point 1 1)))

