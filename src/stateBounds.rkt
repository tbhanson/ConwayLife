#lang racket

(require "../src/timeLessState.rkt")

(define big-integer 999999999999999)
(define small-integer (- 0 big-integer))

; when computing the next state we're interested in the part of the universe with living bits
; so an easy way to "contain" all of these is a rectangle containing all (min x, min y) to (max x, max y)
(define (state-bounds astate)
  (let ((all-x (set-map astate (lambda (pt) (co-x pt)) ))
        (all-y (set-map astate (lambda (pt) (co-y pt)) )))
    (let ((min-x (foldl min big-integer all-x))
          (max-x (foldl max small-integer all-x))
          (min-y (foldl min big-integer all-y))
          (max-y (foldl max small-integer all-y)))
          
      (cons (make-point min-x min-y)
            (make-point max-x max-y)))))

; the easiest way to make sure we get any squares affected by the current state are is to expand the bounds by one
; from the containing rectangle

(define (relevant-space astate)
  (let ((all-x (set-map astate (lambda (pt) (co-x pt)) ))
        (all-y (set-map astate (lambda (pt) (co-y pt)) )))
    (let ((min-x (foldl min big-integer all-x))
          (max-x (foldl max small-integer all-x))
          (min-y (foldl min big-integer all-y))
          (max-y (foldl max small-integer all-y)))
          
      (cons (make-point (- min-x 1) (- min-y 1))
            (make-point (+ max-x 1) (+ max-y 1))))))

(provide state-bounds
         relevant-space
         )
