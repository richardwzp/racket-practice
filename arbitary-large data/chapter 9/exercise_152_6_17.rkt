;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise_152_6_17) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(define circ (circle 5 "solid" "yellow"))
; Natural Number Image -> Image
; consumes a Natural number n and an image,
; produces n copies of the Image horrizontally
(check-expect (row 5 circ) (beside circ circ circ circ circ))
(define (row n img)
  (cond
    [(= n 1) img]
    [(number? n) (beside (row (sub1 n) img) img)]
    ))
; Natural Number Image -> Image
; consumes a Natural number n and an image,
; produces n copies of the Image vertically
(check-expect (col 5 circ) (above circ circ circ circ circ))
(define (col n img)
  (cond
    [(= n 1) img]
    [(number? n) (above (col (sub1 n) img) img)]
    ))