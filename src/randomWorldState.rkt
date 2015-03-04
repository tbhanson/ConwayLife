#lang racket

(require "../src/timeLessState.rkt")

; for kicks build a random world state and watch it unfold
(define (random-world-state width height cell-alive-probability)
  (assert (and (> width 0) (> height 0) (integer? width) (integer? height))
          (format "width and height should be positive integers, you gave me ~a, ~a" width height))
  (assert (and (< 0 cell-alive-probability) (<= cell-alive-probability 1) (real? cell-alive-probability))
          (format "0 < cell-alive-probability <= 1 seems reasonable, but you gave me ~a" cell-alive-probability))
  
  (let ((min-x 0)
        (min-y 0)
        (max-x width)
        (max-y height))
    
    (for*/set ([x (in-range min-x (+ max-x 1))]
               [y (in-range min-y (+ max-y 1))]
               #:when (<= (random) cell-alive-probability))
      (make-point x y))))
      
(provide 
 random-world-state
 )
