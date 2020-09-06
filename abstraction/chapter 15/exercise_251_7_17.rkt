;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise_251_7_17) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; [[List-of Number] -> Number] [List-of Number] -> Number
; compute all number in list using funciton
(check-expect (fold1 + (list 1 2 3)) 6)
(define (fold1 f l)
  (cond
    [(empty? l) 0]
    [else
     (f (first l)
        (fold1 f (rest l)))]))
  