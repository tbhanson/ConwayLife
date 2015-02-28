#lang racket

(require rackunit
         "timeLessState.rkt"
         "stringToTimeLessState.rkt"
         "neighbors.rkt")

(check-equal?
 (count-neighbors (make-state '())
                  (make-point 0 0))
 0)

(check-equal?
 (count-neighbors (strings->state (make-point 0 1) (list " x"))
            (make-point 0 0))
 1)

(check-equal?
 (count-neighbors (strings->state (make-point 0 1) (list "  x"))
            (make-point 0 0))
 0)

(check-equal?
 (count-neighbors (strings->state (make-point -1 1) (list "xxx" "x x" "xxx"))
            (make-point 0 0))
 8)



 

(check-equal?
 (neighbors (strings->state (make-point 0 1) (list " x"))
            (make-point 0 0))
 (list->set (list (make-point 1 1))))

(check-equal?
 (neighbors (strings->state (make-point 0 1) (list "  x"))
            (make-point 0 0))
 (list->set '()))


(check-equal?
 (distance-one? (make-point 0 0) 
               (make-point 0 0))
 #f)

(check-equal?
 (distance-one? (make-point 0 0) 
               (make-point 0 1))
 #t)

(check-equal?
 (distance-one? (make-point 0 0) 
               (make-point 2 1))
 #f)



(check-equal?
 (distance-one? (make-point 0 0) 
               (make-point 1 0))
 #t)

(check-equal?
 (distance-one? (make-point 0 0) 
               (make-point 1 1))
 #t)

(check-equal?
 (distance-one? (make-point -1 -1) 
               (make-point 1 1))
 #f)
               

(check-equal?
 (distance-one? (make-point -1 -1) 
               (make-point 1 1))
 #f)

