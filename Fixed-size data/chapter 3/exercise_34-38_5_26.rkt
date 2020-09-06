#lang racket
(require 2htdp/image)
;;exercise 34
; String -> String
; output first character of str
; given: "apple" expect:"a"
(define (string-first str)
  (substring str 0 1)
  )

;;exercise 35
; String -> String
; output last character of str
; given: "apple" expect: "e"
(define (string-last str)
  (substring str (- (string-length str) 1) (string-length str))
  )

;;exercise 36
; Image -> Number
; take in img, and counts the number of pixels in the image
; given: Image(5x5) expect: 25
(define (image-area img)
  (* (image-height img) (image-width img))
  )

;;exercise 37
; String -> String
; take in str, remove the first character
; given: "apple" expect: "pple"
(define (string-rest str)
  (substring str 1 (string-length str))
  )

;;exercise 38
; String -> String
; take in str, remove the last character
; given: "apple" expect: "appl"
(define (string-remove-last str)
  (substring str 0 (- (string-length str) 1))
)
