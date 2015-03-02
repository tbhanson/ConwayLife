#lang racket

(require plot)
(require "../src/timeLessState.rkt"
         "../src/stateBounds.rkt")
         

;(define WINDOW-SIZE 150)

(define (world-point-to-point world-point)
  (vector (co-x world-point)
          (co-y world-point)))
          
(define (plot-world world)
  (let ((living-world-points (set->list world))
        (plot-bounds (relevant-space world)))
    (plot
     #:x-min (caar plot-bounds)
     #:y-min (cdar plot-bounds)
     #:x-max (cadr plot-bounds)
     #:y-max (cddr plot-bounds)
     
     (points 
      (map world-point-to-point living-world-points)))))
      

(provide plot-world)
