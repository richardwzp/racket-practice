;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise_195_7_3) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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


; Dictionary Letter -> Number
; how many words start with that specific letter
(check-satisfied (starts-with# AS-LIST "a") number?)
(define (starts-with# dic le)
  (cond
    [(empty? dic) 0]
    [(cons? dic)
     (+
      (if (string=? (string-ith (first dic) 0) le) 1 0)
      (starts-with# (rest dic) le)
      )]))