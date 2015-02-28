#lang racket


(require rackunit
         "timeLessState.rkt"
         "stateBounds.rkt"
         )

; degenerate rectangle bounds single point
(check-equal?
  (state-bounds
   (make-state (list (make-point 0 0))))
  (cons (make-point 0 0) (make-point 0 0)))

(check-equal?
  (state-bounds
   (make-state (list (make-point 0 0) (make-point 1 1))))
  (cons (make-point 0 0) (make-point 1 1)))

(check-equal?
  (state-bounds
   (make-state (list (make-point 0 0) (make-point 1 1) (make-point -1 -1))))
  (cons (make-point -1 -1) (make-point 1 1)))


(check-equal?
  (relevant-space
   (make-state (list (make-point 0 0) )))
  (cons (make-point -1 -1) (make-point 1 1)))
