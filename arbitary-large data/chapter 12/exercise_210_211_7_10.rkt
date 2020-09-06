;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise_210_211_7_10) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/batch-io)
(define LOCATION "/usr/share/dict/words")
; A Dictionary is a List-of-strings.
(define AS-LIST (read-lines LOCATION))

; Word -> String
; converts w to a string
(check-expect (word->string (list "h" "e" "r" "e")) "here")
(define (word->string w)
  (cond
    [(empty? w) ""]
    [else
     (string-append (first w) (word->string (rest w)))
     ]))

; List-of-words -> List-of-strings
; turns all Words in low into Strings
(check-expect
 (words->strings (list (list "a" "p" "p" "l" "e") (list "b" "a" "d") (list "g" "o" "o" "d")))
 (list "apple" "bad" "good"))
(define (words->strings low)
  (cond
    [(empty? low) '()]
    [else
     (cons (word->string (first low)) (words->strings (rest low)))
     ]))

; String Dictionary -> Boolean
; determine if string is part of dictionary
(check-expect (dictionary-word? "heart" AS-LIST) #t)
(check-expect (dictionary-word? "heeeeeeert" AS-LIST) #f)
(define (dictionary-word? word dictionary)
  (cond
    [(empty? dictionary) #f]
    [else
     (if (string=? (first dictionary) word) #t (dictionary-word? word (rest dictionary)))
     ]))

; list-of-string -> boolean
; determine if the list are equal disregarding order
(define (member-of-list? los)
  (and
   (member? "heart" los)
   (member? "eat" los)
   (member? "see" los)
   (member? "hey" los)
   (member? "being" los)
   ))

; List-of-strings -> List-of-strings
; picks out all those Strings that occur in the dictionary
(check-satisfied (in-dictionary (list "heart" "eat" "see" "ffff" "grrrrr" "hey" "being"))
              member-of-list?)
(define (in-dictionary los)
  (cond
    [(empty? los) '()]
    [(dictionary-word? (first los) AS-LIST)
     (cons (first los) (in-dictionary (rest los)))]
    [else
     (in-dictionary (rest los))
     ]))


 
