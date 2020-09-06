;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise_164_6_18) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exRate is a Number
; interpretation the amount of euro one USD equals to
(define exRate 0.89)
; List-of-number -> List-of-number
; convert a list of USD to euro
(check-expect (convert-euro (cons 1 (cons 2 '()))) (cons 0.89 (cons 1.78 '())))
(define (convert-euro lus)
  (cond
    [(empty? lus) '()]
    [(cons? lus)
     (cons (* (first lus) exRate) (convert-euro (rest lus))) ]
    ))
; List-of-number -> List-of-number
; convert a list of USD to euro
(check-expect (convert-euro* (cons 1 (cons 2 '())) 0.88) (cons 0.88 (cons 1.76 '())))
(define (convert-euro* lus rate)
  (cond
    [(empty? lus) '()]
    [(cons? lus)
     (cons (* (first lus) rate) (convert-euro* (rest lus) rate)) ]
    ))