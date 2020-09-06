;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_272_7_21) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; [X] [list-of X] [list-of X] -> [list-of X]
; append the two list
(check-expect (append-from-fold `(1 2 3 4 5 6) `(7 8 9)) `(1 2 3 4 5 6 7 8 9))
(define (append-from-fold l1 l2) 
    (foldr (lambda (x y) (cons x y)) l2 l1)
    )

; [list-of Number] -> Number
; compute the sum of the list
(check-expect (sum-of-list `(1 2 3 4 5)) 15)
(define (sum-of-list l)
  (foldr (lambda (x base) (+ x base)) 0 l))

; [list-of Number] -> Number
; compute the sum of the list
(check-expect (product-of-list `(1 2 3 4 5)) 120)
(define (product-of-list l)
  (foldr (lambda (x base) (* x base)) 1 l))
