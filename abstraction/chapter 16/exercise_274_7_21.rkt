;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_274_7_21) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; [list-of 1srting] -> [list-of prefix]
; produce a list of prefix accordinf to the 1string
(check-expect (prefix `("q" "w" "e")) (list (list "q" "w" "e") (list "q" "w") (list "q") '()))
(define (prefix lo1s)
  (local
    (
     ; Number -> String
     ; make a prefix
     (define (produce-prefix 1str base)
       (cons (append (first base) `(,1str)) base))
     )
    (foldl produce-prefix (list '()) lo1s)
    ))

; [list-of 1srting] -> [list-of prefix]
; produce a list of suffix accordinf to the 1string
(check-expect (suffix `("q" "w" "e")) (list (list "q" "w" "e") (list "w" "e") (list "e") '()))
(define (suffix lo1s)
  (local
    (
     ; Number -> String
     ; make a prefix
     (define (produce-suffix 1str base)
       (cons (append `(,1str) (first base)) base))
     )
    (foldr produce-suffix (list '()) lo1s)
    ))