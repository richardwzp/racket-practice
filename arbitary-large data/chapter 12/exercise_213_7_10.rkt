;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise_213_7_10) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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
