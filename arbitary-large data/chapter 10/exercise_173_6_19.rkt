;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise_173_6_19) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/batch-io)

; List-of-list-of-Srting -> String
; convert List-of-list-of-string
; to one string
 (check-expect (convert.v2 (read-words/line "story.txt")) (read-file "story_2.txt"))
 (define (convert.v2 llstr)
  (cond
    [(empty? (rest llstr)) (convert-line.v2 (first llstr))]
    [(cons? llstr)
     (string-append (convert-line.v2 (first llstr))
                    "\n"
                    (convert.v2 (rest llstr))
                   )
     ]))

; helper function
; List-of-String -> String
; convert one line into words
(check-expect (convert-line.v2
               (cons "hey" (cons "what's" (cons "up?" '()))))
              "hey what's up?")
(define (convert-line.v2 ll)
  (cond
    [(empty? ll) ""]
    [(empty? (rest ll)) (string-connect (first ll) "")]
    [(cons? ll)
     (string-connect (first ll) (convert-line.v2 (rest ll)))]
    ))
; helper function
; String String -> String
; if the first string is an article,
; return str2
; else, return both string seperated by " "
(check-expect (string-connect "the" "hello") "hello")
(check-expect (string-connect "and" "hello") "and hello")
(check-expect (string-connect "and" '()) "and")
(define (string-connect str1 str2)
  (if
   (or (string=? str1 "the")
          (string=? str1 "an")
             (string=? str1 "a"))
   str2
   (if (or (empty? str2) (string=? "" str2))
    str1
   (string-append str1 " " str2)
    )))

; filename -> List-of-list-of-string
; remove articles,
; break the file down to a list of string
; (check-expect (remove-article-convert "story.txt") (read-file "story_2.txt"))
(define (remove-article-convert name)
  (write-file (string-append "no-articles-" name)
  (convert.v2 (read-words/line name))
  ))


