;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise_139_6_15) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; List -> Boolean
; determine if all numbers in List are positive
(check-expect (pos? (cons 1 (cons 2 (cons 3 (cons -5 '())))))
             #false)
(check-expect (pos? (cons 1 (cons 2 (cons 3 (cons 5 '())))))
             #true)
(check-expect (pos? (cons 1 (cons -2 (cons 3 (cons 5 '())))))
             #false)
(check-expect (pos? (cons -1 (cons 2 (cons 3 (cons 5 '())))))
             #false)
(define (pos? alon)
  (cond
    [(cons? (rest alon))
     (if (< (first alon) 0) #false (pos? (rest alon)))]
    [else (if (> (first alon) 0) #true #false)]
    ))
; error message
(define MESSAGE "check-sum: input doesn't belong to list-of-number")
; List -> Number/error
; if List belongs to list-of-number, produce sum
; if List doesn't belong to list-of-number, produce error
(check-expect (check-sum (cons 1 (cons 2 (cons 3 (cons 4 '())))))
             10)
(check-error (check-sum (cons "1" (cons 2 (cons 3 (cons 4 '())))))
             MESSAGE)
(check-error (check-sum (cons 1 (cons 2 (cons 3 (cons "4" '())))))
             MESSAGE)
(define (check-sum alon)
  (cond
    [(cons? (rest alon))
     (if (and (number? (first alon)) (> (first alon) 0)) (+ (check-sum (rest alon)) (first alon)) (error MESSAGE))]
    [else (if (and (number? (first alon)) (> (first alon) 0)) (first alon) (error MESSAGE))]
    ))