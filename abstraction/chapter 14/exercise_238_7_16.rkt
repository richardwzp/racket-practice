;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise_238_7_16) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Function Nelon -> Number
; extract the item that is deemed most attractive by function
(check-expect (extract-num > (list 1 2 3 4 5)) 5)
(define (extract-num op l)
  (cond
    [(empty? (rest l))
     (first l)]
    [else
     (if (op (first l)
            (extract-num op (rest l)))
         (first l)
         (extract-num op (rest l)))]))

; Nelon -> Number
; return the max number
(define (inf-1 l)
  (extract-num > l))

; Nelon -> Number
; return the max number
(define (sup-1 l)
  (extract-num < l))


(define ex1 (list 25 24 23 22 21 20 19 18 17 16 15 14 13
      12 11 10 9 8 7 6 5 4 3 2 1))
 
(define ex2 (list 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
      17 18 19 20 21 22 23 24 25))


    