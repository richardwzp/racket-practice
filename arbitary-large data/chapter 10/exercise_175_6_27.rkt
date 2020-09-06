;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise_175_6_27) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/batch-io)
; a wc is a structure of:
; - number-of-words
; - number-of-lines
; - number-of-characters
; (make-wc word line chr)
(define-struct wc [line word chr])

; helper function
; List/String -> Number
(check-expect (is-cons? 2) (cons 2 '()))
(check-expect (is-cons? (cons 3 '())) (cons 3 '()))
(define (is-cons? in)
  (if (cons? in) in (cons in '())))
; List-of-list-of-string -> List-of-String
(check-expect (convert-list (cons 2 (cons (cons 3 (cons 5 '())) (cons 2 '())))) (cons 2 (cons 3 (cons 5 (cons 2 '())))))
(define (convert-list llstr)
  (cond
    [(empty? llstr) '()]
    [(cons? llstr)
     (append (is-cons? (first llstr)) (convert-list (rest llstr)))]
    ))

; List -> Number
(check-expect (count-word-list (convert-list (read-words/line "poem.txt"))) 33)
(define (count-word-list lstr)
  (cond
    [(empty? lstr) 0]
    [else
     (+  (if (empty? (first lstr)) 0 1) (count-word-list (rest lstr)))
     ]
    ))
; List-of-list-of-String -> Number
(check-expect (count-word (read-words/line "poem.txt")) 33)
(define (count-word llstr)
  (count-word-list (convert-list llstr)))
; List-of-List-of-String -> Number
(check-expect (count-line (read-words/line "poem.txt")) 27)
(define (count-line llstr)
  (length llstr))
; fileName -> Number
(check-expect (count-chr "poem.txt") 225)
(define (count-chr llstr)
  (string-length (read-file llstr)))

; List-of-list-of-String fileName -> wc
(check-expect (count (read-words/line "poem.txt") "poem.txt") (make-wc 27 33 225))
(define (count llstr name)
  (make-wc
   (count-line llstr)
   (count-word llstr)
   (count-chr name)
   ))
; IMPORTANT: THE CHARACTER COUNTER DEOS NOT COUNT WHITESPACE YET
; filename -> wc
(check-expect (word-count "poem.txt") (make-wc 27 33 225))
(define (word-count name)
  (count (read-words/line name) name))