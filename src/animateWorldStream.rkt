#lang racket

(require 2htdp/universe)

(require 
  "timeLessState.rkt"
  "worldStateStream.rkt"
  "worldStateStream.rkt"
  "displayWorld.rkt")

; return a finite list composed of at most the first N items in a stream
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

; provide an animated display of a given world 
; - starting from world-starting-state
; - stopping when the state doesn't changes or after max-state-count state's have been displayed
; - pause wait-each-display-in-seconds between states
; terminate if the new state is the same as the current
(define (animate-world-state-stream world-starting-state max-state-count wait-each-display-in-seconds)
  (let ((state-stream (world-state-stream world-starting-state)))
    (let ((state-list (stream-first-N max-state-count state-stream)))
      (let ((boundary-for-all-states (state-list-total-bounds state-list)))
        (let ((display-list
               (map
                (lambda (world-state)
                  (display-bounded-world world-state boundary-for-all-states))
                state-list)))
          
          (run-movie wait-each-display-in-seconds display-list))))))

(provide
 animate-world-state-stream)
