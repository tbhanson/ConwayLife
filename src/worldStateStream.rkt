#lang racket

(require 
  "../src/timeLessState.rkt"
  "nextState.rkt")

; promise a stream of world states starting from the given one, possibly infinite
; terminate if the new state is the same as the current
(define (world-state-stream world-starting-state)
  (stream-cons
   world-starting-state
   (let ((next-state (next-world-state world-starting-state)))
     (if (worlds-equal? world-starting-state next-state)
         empty-stream
         (world-state-stream next-state)))))

(provide
 world-state-stream)
