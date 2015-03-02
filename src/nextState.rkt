#lang racket

(require          "../src/timeLessState.rkt"
                  "../src/neighbors.rkt"
                  "../src/stateBounds.rkt"
)

(define (cell-alive-next-time? point in-state)
  (let ((alive-this-time? (alive-in-world? point in-state))
        (living-neighbors-count (count-neighbors in-state point)))
    (or
     (and alive-this-time? (<= 2 living-neighbors-count) (<= living-neighbors-count 3))
     (and (not alive-this-time?) (= living-neighbors-count 3)))))

(define (next-world-state now-state)
  (let ((working-area (relevant-space now-state)))
    (let ((min-x (caar working-area))
          (min-y (cdar working-area))
          (max-x (cadr working-area))
          (max-y (cddr working-area)))
      (for*/set ([x (in-range min-x (+ max-x 1))]
                 [y (in-range min-y (+ max-y 1))]
                 #:when (cell-alive-next-time? (make-point x y) now-state))
        (make-point x y)))))
        
  
(provide cell-alive-next-time?
         next-world-state)