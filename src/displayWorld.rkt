#lang racket

(require 2htdp/image)
(require "../src/timeLessState.rkt"
         "../src/stateBounds.rkt")

(define cell-square-size 15)
(define alive-cell (overlay
                    (square cell-square-size 'outline 'black)
                    (square cell-square-size 'solid 'seagreen)))
(define dead-cell (square cell-square-size 'outline 'black))


(define (world-row->image world row-y lo-x hi-x)
  ; this helped: http://stackoverflow.com/questions/15040527/how-am-i-supposed-to-create-rows-and-columns-of-images
  (define (row->image row)
    (cond
      [(empty? row) empty-image]
      [else         (beside (first row) 
                            (row->image (rest row)))]))
  
  (define (iter so-far now-x)
    (if (< now-x lo-x)
        so-far
        (iter 
         (cons
          (if (alive-in-world? (make-point now-x row-y) world)
              alive-cell
              dead-cell) 
          so-far)
         (- now-x 1))))
  (row->image
   (iter '() hi-x)))

(define (display-world world)
  (define (image-row-list->image image-rows)
    (cond
      [(empty? image-rows) empty-image]
      [else         (above (first image-rows) 
                           (image-row-list->image (rest image-rows)))]))

  (let ((plot-bounds (relevant-space world)))
    (let ((min-x (caar plot-bounds))
          (min-y (cdar plot-bounds))
          (max-x (cadr plot-bounds))
          (max-y (cddr plot-bounds)))
      (image-row-list->image
       (for/list ([y (in-range max-y (- min-y 1) -1)]) ; let y count down from top to bottom
         (world-row->image world y min-x max-x))))))
        

(provide display-world)

