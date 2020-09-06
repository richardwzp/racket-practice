;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_309_7_28) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/abstraction)
; [list-of [list-of String]] -> [list-of Number]
; determine the number of string per item
(check-expect (words-on-line `(("hello" "yes") ("1" "2" "3") ("4") ("5" "6" "7" "8"))) `(2 3 1 4))
(define (words-on-line lolos)
  (for/list ([i lolos])
    (for/sum ([j i])
      1)
    ))