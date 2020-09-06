;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise_250_7_17) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Number [Number -> Number] -> [List-of Number]
; tabulates numbers
(check-within (tab 5 sqrt) (list (sqrt 5) (sqrt 4) (sqrt 3) (sqrt 2) (sqrt 1) 0) 0.1)
(define (tab n f)
  (cond
    [(= n 0) (list (f 0))]
    [else
     (cons
      (f n)
      (tab (sub1 n) f))]))

; Number -> [List-of Number]
; tabulates sqrt between n 
; and 0 (incl.) in a list
(check-within (tabulate-sqrt 5) (list (sqrt 5) (sqrt 4) (sqrt 3) (sqrt 2) (sqrt 1) 0) 0.1)
(define (tabulate-sqrt n)
  (tab n sqrt))

; Number -> [List-of Number]
; tabulates sin between n 
; and 0 (incl.) in a list
(check-within (tabulate-sin 5) (list (sin 5) (sin 4) (sin 3) (sin 2) (sin 1) (sin 0)) 0.1)
(define (tabulate-sin n)
  (tab n sin))