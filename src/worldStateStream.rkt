#lang racket

(require 
  "timeLessState.rkt"
  "nextState.rkt"
  "stateBounds.rkt"
  )

; promise a stream of world states starting from the given one, possibly infinite
; terminate if the new state is the same as the current
(define (world-state-stream world-starting-state)
  (stream-cons
   world-starting-state
   (let ((next-state (next-world-state world-starting-state)))
     (if (worlds-equal? world-starting-state next-state)
         empty-stream
         (world-state-stream next-state)))))

; promise a stream of state-bounds, one for each world state given
(define (world-state-bounds stream-of-world-states)
  (stream-map state-bounds stream-of-world-states))

; given a finite stream of world states, return the smallest bounding rectangle enclosing all of them 
(define (stream-total-bounds finite-stream-of-world-states)
  (let ((bounds-of-each (world-state-bounds finite-stream-of-world-states)))
    (if (stream-empty? bounds-of-each)
        (error "sorry, hard to know what bound to return for an empty stream of states")
        (let ((bounds-of-first-state (stream-first bounds-of-each)))
          (stream-fold combine-bounds bounds-of-first-state (stream-rest bounds-of-each))))))

(provide
 world-state-stream
 world-state-bounds
 stream-total-bounds)
