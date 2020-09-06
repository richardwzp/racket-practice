;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise_64_5_31) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; posn -> number
; count the number of step
; it takes to go back to origin
(check-expect (step (make-posn 1 4)) 5)
(define (step ap)
  (+ (posn-x ap) (posn-y ap)))