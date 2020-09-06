;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise_189_7_2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; #Example#
; Number List-of-numbers -> Boolean
(define (search n alon)
  (cond
    [(empty? alon) #false]
    [else (or (= (first alon) n)
              (search n (rest alon)))]))

; Number List-of-numbers -> Boolean
; search a ascended sorted list for the occurence of a number
(check-expect (search-ascen 5 (list 1 2 3 4 5 6)) #t)
(check-expect (search-ascen 5 (list 1 2 3 4 4 6 7)) #f)
(define (search-ascen n l)
  (cond
    [(empty? l) #f]
    [(< n (first l)) #f]
    [(cons? l)
     (or (= n (first l)) (search-ascen n (rest l)))]
    ))

; Number List-of-numbers -> Boolean
; search a descended sorted list for the occurence of a number
(check-expect (search-des 5 (list 6 5 4 3 2 1)) #t)
(check-expect (search-des 5 (list 7 6 4 3 2 1)) #f)
(define (search-des n l)
  (cond
    [(empty? l) #f]
    [(> n (first l)) #f]
    [(cons? l)
     (or (= n (first l)) (search-des n (rest l)))]
    ))

; Number List-of-numbers -> Boolean
; search a sorted list for the occurence of a number
(check-expect (search-sorted 5 (list 1 2 3 4 5 6)) #t)
(check-expect (search-sorted 5 (list 1 2 3 4 4 6 7)) #f)
(check-expect (search-sorted 5 (list 6 5 4 3 2 1)) #t)
(check-expect (search-sorted 5 (list 7 6 4 3 2 1)) #f)
(define (search-sorted n l)
  (cond
    [(or (empty? l) (= (length l) 1)) (equal? n (first l))]
    [(<= (first l) (second l) (third l)) (search-ascen n l)]
    [(>= (first l) (second l) (third l)) (search-des n l)]
    ))