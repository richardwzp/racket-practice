;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise_163_6_18) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define listF (cons 32 (cons 41 '())))
; List-of-number -> List-of-number
; convert a list of fahrenheit to Celcius
(check-expect (convertFC listF) (cons 0 (cons 5 '())))
(define (convertFC lf)
  (cond
    [(empty? lf) '()]
    [(cons? lf)
     (cons (FtoC (first lf)) (convertFC (rest lf)))]
    ))
; Number -> Number
; convert Fahrenheit to Celcius
(check-expect (FtoC 32) 0)
(define (FtoC f)
        (/ (*(- f 32) 5) 9))