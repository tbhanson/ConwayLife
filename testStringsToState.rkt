#lang racket

(require rackunit
         "timeLessState.rkt"
         "stringToTimeLessState.rkt")

(check-equal? 
 (filled-cell-char? #\.)
 #f)

(check-equal? 
 (filled-cell-char? #\x)
 #t)

(check-equal?
 (add-string-points (make-state '()) (make-point 0 0) "")
 (make-state '()))

(check-equal?
 (add-string-points (make-state '()) (make-point 0 0) " ")
 (make-state '()))

(check-equal?
 (add-string-points (make-state '()) (make-point 0 0) "x")
 (make-state (list (make-point 0 0))))


 
 

(check-equal?
 (strings->state (make-point 0 0) '())
 (make-state '()))

(check-equal?
 (strings->state (make-point 0 0) (list "x"))
 (make-state (list (make-point 0 0))))

(check-equal?
 (strings->state (make-point 0 0) (list "x" "x"))
 (make-state (list (make-point 0 0)
                   (make-point 0 -1)
                   )))

(check-equal?
 (strings->state (make-point 0 0) (list "xx" "x"))
 (make-state (list (make-point 0 0)
                   (make-point 1 0)
                   (make-point 0 -1)
                   )))

(check-equal?
 (strings->state (make-point 0 0) (list "xx" "xx"))
 (make-state (list (make-point 0 0)
                   (make-point 1 0)
                   (make-point 0 -1)
                   (make-point 1 -1)
                   )))
