;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise_197_7_3) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/batch-io)
(define LOCATION "/usr/share/dict/words")
; A Dictionary is a List-of-strings.
(define AS-LIST (read-lines LOCATION))

; A Letter is one of the following 1Strings: 
; – "a"
; – ... 
; – "z"
; or, equivalently, a member? of this list: 
(define LETTERS
  (explode "abcdefghijklmnopqrstuvwxyz"))

; A count is a definition of:
; [Letter count]
; (make-loc 1String Number)
(define-struct loc [letter count])

; Dictionary Letter -> Number
; how many words start with that specific letter
(check-satisfied (starts-with# AS-LIST "a") number?)
(check-expect (starts-with# (list "hello" "man" "hi" "ok") "h") 2)
(define (starts-with# dic le)
  (cond
    [(empty? dic) 0]
    [(cons? dic)
     (+
      (if (string=? (string-ith (first dic) 0) le) 1 0)
      (starts-with# (rest dic) le)
      )]))

; count-by-letter helper function
; Dictionary Letters -> List-of-count
; how many times each letter occurs as first of word
(check-expect
 (count-letter-dictionary (list "hello" "man" "hi" "ok")
               (list "h" "m" "a"))
 (list (make-loc "h" 2) (make-loc "m" 1) (make-loc "a" 0)))
(define (count-letter-dictionary dic LETTERS)
  (cond
    [(empty? LETTERS) '()]
    [(cons? LETTERS)
     (cons (make-loc (first LETTERS) (starts-with# dic (first LETTERS)))
           (count-letter-dictionary dic (rest LETTERS)))
     ]))

; Dictionary -> List-of-count
; how many times each letter occur as first of word
(check-satisfied (count-by-letter (list "hello" "heheh" "her")) cons?)
(define (count-by-letter dic)
  (count-letter-dictionary dic LETTERS))