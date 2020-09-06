;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_273_7_21) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; [X Y] [X->Y] [list-of X] -> [list-of Y]
(check-expect (fold-map (lambda (x) (+ x 1)) `(1 2 3)) `(2 3 4))
(define (fold-map f l)
  (foldr (lambda (x base) (cons (f x) base)) '() l))