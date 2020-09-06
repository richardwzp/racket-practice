;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise_74_6_1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; posn Number -> posn
; change posn x's x coordinate
; to number x-posn
; given (5 3) 3 expect: (3 3)
(check-expect (posn-x-p (make-posn 5 3) 3) (make-posn 3 3))
(define (posn-x-p x x-posn)
  (make-posn x-posn (posn-y x))
  )
