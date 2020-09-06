;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_299_7_26) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Number -> Boolean
; data representation of all even number
(check-expect (even-set 2) #t)
(check-expect (even-set 3) #f)
(define even-set
  (lambda (l0)
    (= 0 (remainder l0 2))))

;  Number -> Boolean
; data representation of all odd number
(check-expect (odd-set 2) #f)
(check-expect (odd-set 3) #t)
(define odd-set
  (lambda (l0)
    (= 1 (remainder l0 2))))

;  Number -> Boolean
; data representation of all number divisible by 10
(check-expect (div-10-set 10) #t)
(check-expect (div-10-set 11) #f)
(define div-10-set
  (lambda (l0)
    (= 0 (remainder l0 10))))

; set element -> Boolean
; data representation which has one extra element
(check-expect ((add-element even-set 3) 3) #t)
(define (add-element s1 s2)
  (lambda (l0)
    (or
     (s1 l0)
     (= s2 l0)
     )))

; set element -> Boolean
; data representation which combine two set
(check-expect ((union even-set odd-set) 3) #t)
(define (union s1 s2)
  (lambda (l0)
    (or
     (s1 l0)
     (s2 l0)
     )))

; set element -> Boolean
; data representation which combine two set
(check-expect ((intersect even-set odd-set) 3) #f)
(check-expect ((intersect div-10-set even-set) 10) #t)
(define (intersect s1 s2)
  (lambda (l0)
    (and
     (s1 l0)
     (s2 l0)
     )))





