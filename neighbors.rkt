#lang racket

(require "timeLessState.rkt")

; in live 2 points are neighbors if one or both coordinates are distance 1 apart

(define (distance-one? p1 p2)
  (let ((x1 (co-x p1))
        (x2 (co-x p2))
        (y1 (co-y p1))
        (y2 (co-y p2)))
    (let ((abdx (abs (- x2 x1)))
          (abdy (abs (- y2 y1))))
      (and (<= abdx 1)
           (<= abdy 1)
           (or (= abdx 1)
               (= abdy 1))))))
        
; return from state the set of neighboring (occupied) points to point
(define (neighbors state point)
  (list->set
   (filter (lambda (p) (distance-one? p point)) (set->list state))))

(define (count-neighbors state point)
  (set-count (neighbors state point)))

(provide distance-one?
         neighbors
         count-neighbors
         )
