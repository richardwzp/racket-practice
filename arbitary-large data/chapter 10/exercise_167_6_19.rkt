;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise_167_6_19) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; List-of-posn -> Number
; return the sum of the x coordinates
; of the List-of-posn
(check-expect (sum (cons (make-posn 1 2) (cons (make-posn 3 4) (cons (make-posn 6 7) '())))) 10)
(define (sum lpos)
  (cond
    [(empty? lpos) 0]
    [(cons? lpos) (+ (posn-x (first lpos)) (sum (rest lpos)))]
    ))