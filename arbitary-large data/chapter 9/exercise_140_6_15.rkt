;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise_140_6_15) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; List -> Boolean
; consume a list-of-boolean,
; determine if all elements of the list are #true
(check-expect (all-one (cons #true (cons #true (cons #true (cons #true '()))))) #true)
(check-expect (all-one (cons #false (cons #true (cons #true (cons #true '()))))) #false)
(check-expect (all-one (cons #true (cons #true (cons #true (cons #false '()))))) #false)
(define (all-one alon)
  (cond
    [(cons? (rest alon)) (if (first alon) (all-one (rest alon)) #false)]
    [else (if (first alon) #true #false)]
    ))
; List -> Boolean
; consume a list-boolean,
; determine if one of the elements is #true
(check-expect (one-true (cons #false (cons #false (cons #false (cons #true '()))))) #true)
(check-expect (one-true (cons #false (cons #false (cons #false (cons #false '()))))) #false)
(check-expect (one-true (cons #true (cons #false (cons #false (cons #true '()))))) #true)
(define (one-true alon)
  (cond
    [(cons? (rest alon)) (if (first alon) #true (one-true (rest alon)))]
    [else (if (first alon) #true #false)]
    ))