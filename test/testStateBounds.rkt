#lang racket


(require rackunit
         "../src/timeLessState.rkt"
         "../src/stateBounds.rkt"
         )

; degenerate rectangle bounds single point
(check-equal?
  (state-bounds
   (make-state (list (make-point 0 0))))
  (cons (make-point 0 0) (make-point 0 0)))

; but with a margin request we can expand it
(check-equal?
 (margined-bounded-space 
   (make-state (list (make-point 0 0)))
   3)
  (cons (make-point -3 -3) (make-point 3 3)))

    
(check-equal?
  (state-bounds
   (make-state (list (make-point 0 0) (make-point 1 1))))
  (cons (make-point 0 0) (make-point 1 1)))

(check-equal?
  (state-bounds
   (make-state (list (make-point 0 0) (make-point 1 1) (make-point -1 -1))))
  (cons (make-point -1 -1) (make-point 1 1)))


; relevant space means a minimum boundary plus a margin of 1 (to make sure possible births just outside are computed)
(check-equal?
  (relevant-space
   (make-state (list (make-point 0 0) )))
  (cons (make-point -1 -1) (make-point 1 1)))

; combining 2 boundaries means placing a rectangle that encloses both rectangles
(check-equal?
 (combine-bounds
  (state-bounds
   (make-state (list (make-point 0 0) (make-point 1 1) (make-point -1 -1))))
  (state-bounds
   (make-state (list (make-point 5 5) (make-point 3 3)))))
  
  (cons (make-point -1 -1) (make-point 5 5)))
