;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_275_7_22) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/batch-io)
; On OS X: 
(define LOCATION "/usr/share/dict/words")
; A Dictionary is a List-of-strings.
(define AS-LIST (read-lines LOCATION))

; Dictionary -> Number
; count the most frequent first letter of list of words
;(check-expect (most-frequent `("hello" "hey" "damn")) `("h" "h" "d"))
(check-expect (most-frequent `("hello" "sir" "hi" "welcome" "back" "hehe" "is" "and" "hilarious")) 4)
(define (most-frequent dic)
  (local
    (; String -> [list-of 1String]
     ; turn a string into a list of 1 string
     (define (string-to-list str)
       (cond
         [(string=? str "") '()]
         [else
          (cons (string-ith str 0) (string-to-list (substring str 1 (string-length str))))]
         ))
     ; Dictionary -> [list-of [list-of 1String]]
     ; turn the list of string into list of list of 1srting
     (define dictionary-list (map string-to-list dic))
     ; [list-of [list-of 1String]] -> [list-of 1string]
     ; produce a list of first letter of dictionary
     (define first-letter (map (lambda (x) (first x)) dictionary-list))
     ; a letter is a structure of:
     ; - (make-letter 1String Number)
     ; it represent the letter and its frequency
     (define-struct letter [l fre])
     ; 1String [list-of letter] -> Boolean
     ; see if letter exist in list
     (define (exist-in-library? le base)
       (ormap
        [lambda (x)
          (cond
            [(string=? le (letter-l x)) #t]
            [else #f]
            )]
        base))
     ; 1String [list-of letter] -> [list-of letter]
     ; increase the count of letter by one in list
     (define (add-count le base)
       (map
        [lambda (x) (if (string=? le (letter-l x)) (make-letter le (add1 (letter-fre x))) x)]
        base))
     ; 1String [list-of letter] -> [list-of letter]
     ; if the letter is already reccorded, add count by 1
     ; if the letter has not occured, add the key
     (define (record-letter le base)
       (cond
         [(exist-in-library? le base) (add-count le base)]
         [else (cons (make-letter le 1) base)]
         ))
     ; count all occurance of first letter, the return is [list-of letter]
     (define dictionary-record (foldr record-letter '() first-letter))
     )
    ; return the highest letter count
    (letter-fre (argmax letter-fre dictionary-record))
    ))