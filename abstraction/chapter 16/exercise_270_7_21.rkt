;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_270_7_21) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; number -> [list-of Number]
; create a list of number from 0 to n-1
(check-expect (basic-list 5) `(0 1 2 3 4))
(define (basic-list n)
  (build-list n (lambda (x) x)))

; number -> [list-of Number]
; create a list of number from 1 to n
(check-expect (natural-list 5) `(1 2 3 4 5))
(define (natural-list n)
  (build-list n (lambda (x) (+ x 1))))

; number -> [list-of Number]
; create a list of number from 0 to n-1
(check-expect (frac-list 5) `(1 ,(/ 1 2) ,(/ 1 3) ,(/ 1 4) ,(/ 1 5)))
(define (frac-list n)
  (build-list n (lambda (x) (/ 1 (+ x 1)))))