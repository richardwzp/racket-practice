;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise_151_6_151) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Number -> Number
; consumes a natural number n, and multiple
; it by an arbitary number x
(check-within (multiply 3 5) 15 0.01)
(define (multiply n x)
  (cond
    [(zero? n) 0]
    [(number? n) (+ (multiply (sub1 n) x) x)]
    ))