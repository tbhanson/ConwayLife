#lang racket

(require rackunit
         "../src/timeLessState.rkt"
         "../src/animateWorldStream.rkt"
         "../src/randomWorldState.rkt"
         )


(animate-world-state-stream 
 (random-world-state 10 10 0.25)
 100 ; max state count
 0.25) ; seconds each picture

