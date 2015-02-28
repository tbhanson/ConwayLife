#lang racket

(require "timeLessState.rkt")

; we will support a shorthand allowing us to describe states with picture-like lists of strings)
; e.g. (0,0) "x."
;            "xx"
; represents the state of three points (0,0), (0, -1), and (1, -1)
;

(define (filled-cell-char? ch)
  (let ((chlo (char-downcase ch)))
    (or (equal? #\x ch)
        (equal? #\* ch))))
        

;
(define (add-string-points state left-point str)
  (define (iter state-so-far curr-pt chars-remaining)
    (if (null? chars-remaining)
        state-so-far
        (let ((next-pt (make-point (+ 1 (co-x curr-pt)) (co-y curr-pt)))
              (next-char (car chars-remaining))
              (rest-chars (cdr chars-remaining)))
          (if (filled-cell-char? next-char)
              (iter (state-add-point state-so-far curr-pt) next-pt rest-chars)
              (iter state-so-far next-pt rest-chars)))))
  (iter state left-point (string->list str)))

              
          
  
(define (strings->state upper-left list-of-strings)
  (let ((min-x (co-x upper-left))
        (max-y (co-y upper-left)))
    (let ((end-y (- max-y (length list-of-strings)))) ; actually 1 past, because of how in-range counts
      ;(printf "max-y: ~a, end-y: ~a~n" max-y end-y)
      (for/fold ([state-so-far (make-state '())])   ; accumulator begins empty
                ([curr-y (in-range max-y end-y -1)] ; loop y downwards
                 [curr-string list-of-strings])
        ;(printf "debug: state-so-far: ~a~n curr-y: ~a, curr-string: ~a~n" state-so-far curr-y curr-string)
        (add-string-points state-so-far (make-point min-x curr-y) curr-string)))))
                
    
    
    


(provide filled-cell-char?
         add-string-points
         strings->state)