;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise_146_6_15) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; NElist-of-temperature is one of
; - (cons cTemp '())
; - (cons cTemp NElist-of-temperature)

; NElist -> Number
; determine how many element NElist contains
(check-expect (how-many (cons 1 (cons 2 (cons 3 (cons 4 '()))))) 4)
(define (how-many NElist)
  (cond
    [(empty? (rest NElist)) 1]
    [else (+ (how-many (rest NElist)) 1)]
    ))
; NElist -> Number
; determine the sum of NElist elements
(check-expect (sum (cons 1 (cons 2 (cons 3 (cons 4 '()))))) 10)
(define (sum NElist)
  (cond
    [(empty? (rest NElist)) (first NElist)]
    [else (+ (sum (rest NElist)) (first NElist))]
    ))
; NElist -> Number
; determine the average of NElist
(check-expect (average (cons 1 (cons 2 (cons 3 (cons 4 '()))))) 2.5)
(define (average NElist)
  (/ (sum NElist) (how-many NElist)))
