;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise_138_6_14) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; List_of_amount is one of:
; - '()
; (cons PositiveNumber List_of_amount)
; (define List_of_amount
;   ...)

; alon -> Number
; sum up all the number in the list
(check-expect
 (sum (cons 5 (cons 6 (cons 7 '()))))
 18)
(define (sum l)
  (cond
    [(empty? (rest l)) (first l)]
    [else (+ (sum (rest l)) (first l))]
    ))