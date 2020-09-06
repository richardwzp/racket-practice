;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise_160_6_18) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define set.L (cons 1(cons 2(cons 3 '()))))
(define set.R (cons 1(cons 2(cons 3 '()))))

; Set -> Set
; add number x to set s
; left-banded defintion
(check-expect (set+.L 1 set.L) (cons 1(cons 1(cons 2(cons 3 '())))))
(define (set+.L n s)
  (list* n s))
; Set -> Set
; add number x to set s
; left-banded defintion
(check-expect (set+.R 1 set.L) (cons 1 (cons 2(cons 3 '()))))
(check-expect (set+.R 4 set.L) (cons 4 (cons 1 (cons 2(cons 3 '())))))
(define (set+.R n s)
  (if (member? n s) s (list* n s)))
