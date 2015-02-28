#lang racket

(require "timeLessState.rkt")

(define big-integer 999999999999999)
(define small-integer (- 0 999999999999999))

(define (state-bounds astate)
  (let ((all-x (set-map astate (lambda (pt) (co-x pt)) ))
        (all-y (set-map astate (lambda (pt) (co-y pt)) )))
    (let ((min-x (foldl min big-integer all-x))
          (max-x (foldl max small-integer all-x))
          (min-y (foldl min big-integer all-y))
          (max-y (foldl max small-integer all-y)))
          
      (cons (make-point min-x min-y)
            (make-point max-x max-y)))))

(provide state-bounds
         )
