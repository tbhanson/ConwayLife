#lang racket

(require rackunit
         "../src/timeLessState.rkt")

(check-equal?
 (co-x (make-point 1 2))
 1)

(check-equal?
 (co-y (make-point 1 2))
 2)

(check-equal?
 (set-empty? 
  (make-state '()))
 #t)

(check-equal?
 (equal? 
  (make-state (list (make-point 1 2)))
  (make-state (list (make-point 2 1))))  
 #f)

(check-equal?
 (equal? 
  (make-state (list (make-point 1 2)))
  (make-state (list (make-point 1 2))))  
 #t)

(check-equal?
 (equal? 
  (make-state (list (make-point 1 2) (make-point 0 0)))
  (make-state (list (make-point 0 0) (make-point 1 2))))  
 #t)

(check-equal?
 (equal? 
  (make-state (list (make-point 0 0) (make-point 0 0)))
  (make-state (list (make-point 1 2))))  
 #f)

(check-equal?
 (equal? 
  (make-state (list (make-point 0 0) (make-point 0 0)))
  (make-state (list (make-point 0 0))))  
 #t)

(check-equal?
 (alive-in-world? (make-point 1 2)
                   (make-state (list (make-point 1 2))))
 #t)

(check-equal?
 (alive-in-world? (make-point 1 2)
                  (make-state '()))
  #f)

(check-equal?
 (alive-in-world? (make-point 1 2)
                  (make-state (list (make-point 2 1))))  
  #f)


(check-equal?
  (make-state (list (make-point 0 0) (make-point 1 2)))
  (state-add-point
   (make-state (list (make-point 0 0)))
   (make-point 1 2)))

  