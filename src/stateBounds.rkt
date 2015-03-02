#lang racket

(require "../src/timeLessState.rkt")

(define big-integer 999999999999999)
(define small-integer (- 0 big-integer))

(define (make-bounds min-x min-y max-x max-y)
  (cons (make-point min-x min-y)
        (make-point max-x max-y)))
  

(define bounds-of-empty-space 
  (make-bounds -5 -5 5 5)) ; empty space bounds would be arbitrary!!

; when computing the next state we're interested in the part of the universe with living bits
; so an easy way to "contain" all of these is a rectangle containing all (min x, min y) to (max x, max y)
(define (state-bounds astate)
  (if (world-empty? astate)
      bounds-of-empty-space
      (let ((all-x (set-map astate (lambda (pt) (co-x pt)) ))
            (all-y (set-map astate (lambda (pt) (co-y pt)) )))
        (let ((min-x (foldl min big-integer all-x))
              (max-x (foldl max small-integer all-x))
              (min-y (foldl min big-integer all-y))
              (max-y (foldl max small-integer all-y)))
          (make-bounds min-x min-y max-x max-y)))))


; the easiest way to make sure we get any squares affected by the current state are is to expand the bounds by one
; from the containing rectangle

(define (margined-bounded-space astate margin)
  (assert (>= margin 0) (format "margin must be non-negative! i got ~a" margin))
  (assert (integer? margin) (format "margin must be an integer! i got ~a" margin))
  
  (let ((bounds (state-bounds astate)))
    (let ((min-x (caar bounds))
          (min-y (cdar bounds))
          (max-x (cadr bounds))
          (max-y (cddr bounds)))
    (make-bounds (- min-x margin) (- min-y margin) 
                 (+ max-x margin) (+ max-y margin)))))

; leave margin of 1 outside all material to assure no neglected interactions
(define (relevant-space astate)
  (margined-bounded-space astate 1))

(provide state-bounds
         relevant-space
         )
