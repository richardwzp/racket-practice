;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise_214_7_10) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/batch-io)
(define LOCATION "/usr/share/dict/words")
; A Dictionary is a List-of-strings.
(define AS-LIST (read-lines LOCATION))

; A Word is one of:
; – '() or
; – (cons 1String Word)
; interpretation a Word is a list of 1Strings (letters)

; A List-of-Word is one of:
; - '() or
; - (cons Word List-of-Word)
; interpretation a List-of-Word is a list of Words

; 1String List-of-words -> List-of-Words
; append the 1string to the start of every word
(check-expect (append-to-first "d" (list (list "a" "b"))) (list (list "d" "a" "b")))
(define (append-to-first str low)
  (cond
    [(empty? low) '()]
    [else
     (cons (append (cons str '()) (first low)) (append-to-first str (rest low)))
     ]))

; predicate for insert-letter-in-word
; List-of-words -> Boolean
(define (member-of-insert-in-word? low)
  (and
   (member? (list "d" "e" "r") low)
   (member? (list "e" "d" "r") low)
   (member? (list "e" "r" "d") low)
   ))

; 1String Word -> list-of-words
; produce a list of words that has 1string inserted everywhere
(check-satisfied (insert-letter-in-word "d" (list "e" "r")) member-of-insert-in-word?)
(define (insert-letter-in-word str low)
  (cond
    [(empty? low) (cons (cons str '()) '())]
    [else
     (cons (append (cons str '()) low) (append-to-first (first low) (insert-letter-in-word str (rest low))))
     ]))

; predicate for insert-everywhere
; List-of-words -> boolean
; determine if the list of words are membe
(define example (list (list "d" "e" "r") (list "e" "d" "r") (list "e" "r" "d") (list "d" "r" "e") (list "r" "d" "e") (list "r" "e" "d")))
(define (member-of-insert-everywhere? low)
  (cond
    [(empty? low) #t]
   [else
    (if (member? (first low) example) (member-of-insert-everywhere? (rest low)) #f)]))

; 1String List-of-words -> List-of-words
; return a list of words with 1string being inserted at every
; location of the list of words
(check-satisfied (insert-everywhere/in-all-words "d" (list (list "e" "r") (list "r" "e")))
                 member-of-insert-everywhere?)
(define (insert-everywhere/in-all-words str low)
  (cond
    [(empty? low) '()]
    [else
     (append (insert-letter-in-word str (first low)) (insert-everywhere/in-all-words str (rest low)))
     ]))

(define (arrangements w)
  (cond
    [(empty? w) (list '())]
    [else (insert-everywhere/in-all-words (first w)
            (arrangements (rest w)))]))

; List-of-strings -> Boolean
(define (all-words-from-rat? w)
  (and
    (member? "rat" w) (member? "art" w) (member? "tar" w)))
 
; String -> List-of-strings
; finds all words that the letters of some given word spell
 
(check-member-of (alternative-words "cat")
                 (list "act" "cat")
                 (list "cat" "act"))
 
(check-satisfied (alternative-words "rat")
                 all-words-from-rat?)

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

; Stirng -> list-of-Words
; rearrange the words, and produce a list of words that are in the dictionary
(define (alternative-words s)
  (in-dictionary
    (words->strings (arrangements (string->word s)))))