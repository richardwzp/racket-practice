;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise_209_7_10) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; String -> Word
; converts s to the chosen word representation 
(check-expect (string->word "here") (list "h" "e" "r" "e"))
(define (string->word s)
  (cond
    [(string=? s "") '()]
    [else
     (cons (string-ith s 0) (string->word (substring s 1 (string-length s))))
     ]))
 
; Word -> String
; converts w to a string
(check-expect (word->string (list "h" "e" "r" "e")) "here")
(define (word->string w)
  (cond
    [(empty? w) ""]
    [else
     (string-append (first w) (word->string (rest w)))
     ]))
