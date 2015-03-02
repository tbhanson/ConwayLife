#lang racket

(define (assert pred anError)
  (if (not pred) 
      (raise anError)
      #t))

; we will think of an instantaneous world state as a set of occupied points
; each point is a pair (or perhaps a list with 2 items) of signed integers

(define (make-point x y)
  (assert (integer? x) (format "(make-point x y) wants 2 integers, you gave ~a for x" x))
  (assert (integer? y) (format "(make-point x y) wants 2 integers, you gave ~a for y" y))
  (cons x y))

(define (co-x pt)
  (car pt))

(define (co-y pt)
  (cdr pt))


(define (make-state list-of-points)
  (list->set list-of-points))

(define (alive-in-world? point world)
  (set-member? world point))

(define (state-add-point state pt)
  (set-union state (make-state (list pt))))
  
(define (merge-worlds w1 w2)
  (set-union w1 w2))

(define (world-empty? world)
  (set-empty? world))
            
          

(provide 
 assert
 make-point co-x co-y 
 make-state
 alive-in-world?
 state-add-point
 world-empty?
 )
