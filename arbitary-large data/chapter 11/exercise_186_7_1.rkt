;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise_186_7_1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; List-of-numbers -> List-of-numbers
; produces a sorted version of l
(check-satisfied (sort> (list 1 5 3 2 6 2)) sort>?)
(define (sort> l)
  (cond
    [(empty? l) '()]
    [(cons? l) (insert (first l) (sort> (rest l)))]))
 
; Number List-of-numbers -> List-of-numbers
; inserts n into the sorted list of numbers l
(check-satisfied (insert 5 (list 9 8 7 6 4 3 2)) sort>?)
(define (insert n l)
  (cond
    [(empty? l) (cons n '())]
    [else (if (>= n (first l))
              (cons n l)
              (cons (first l) (insert n (rest l))))]))
; List-of-numbers -> Boolean
; check if the list is in desending order
(check-expect (sort>? (list 1 2 3 4 5)) #f)
(check-expect (sort>? (list 5 4 3 2 1)) #t)
(define (sort>? alon)
  (cond
    [(empty? (rest alon)) #t]
    [(cons? (rest alon)) (and (>= (first alon) (first (rest alon))) (sort>? (rest alon)))]
    ))