#lang racket

(require 2htdp/universe)

(require 
  "timeLessState.rkt"
  "worldStateStream.rkt"
  "worldStateStream.rkt"
  "displayWorld.rkt")

(define (stream-first-N N astream)
  (assert (stream? astream) "argument astream must be a stream!")
  (assert (integer? N) "argument N must be an integer")
  (assert (> N 0) "argument N must be a counting number")
  
  (letrec ((iter 
            (lambda (result-so-far i remaining-stream)
              (if (or
                   (> i N)
                   (stream-empty? remaining-stream))
                  result-so-far
                  (iter
                   (cons (stream-first remaining-stream)
                         result-so-far)
                   (+ i 1)
                   (stream-rest remaining-stream))))))
    (reverse 
     (iter '() 1 astream))))

; promise a stream of world states starting from the given one, possibly infinite
; terminate if the new state is the same as the current
(define (animate-world-state-stream world-starting-state max-state-count wait-each-display-in-seconds)
  (let ((state-stream (world-state-stream world-starting-state)))
    (let ((display-list
           (stream-first-N 
            max-state-count
            (stream-map
             display-world
             state-stream))))
            
      (run-movie wait-each-display-in-seconds display-list))))

(provide
 animate-world-state-stream)
