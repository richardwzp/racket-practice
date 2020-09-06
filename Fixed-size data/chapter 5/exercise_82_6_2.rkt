;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise_82_6_2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct words [first second third])
; 3p 3p -> 3p
; take in two instances of
; words, and comapre their letters
; if they agree, return the letter
; if they don't, return false
(check-expect
 (compare-word (make-words "a" "b" "c") (make-words "a" "b" "c"))
 (make-words "a" "b" "c")
 )
(check-expect
 (compare-word (make-words "a" "b" "c") (make-words "a" "f" "c"))
 (make-words "a" #false "c")
 )
(define (compare-word p1 p2)
  (make-words
    (if (string=? (words-first p1) (words-first p2)) (words-first p1) #false)
    (if (string=? (words-second p1) (words-second p2)) (words-second p1) #false)
    (if (string=? (words-third p1) (words-third p2)) (words-third p1) #false)
    )
  )