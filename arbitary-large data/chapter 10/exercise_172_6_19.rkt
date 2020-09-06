;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise_172_6_19) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/batch-io)
; List-of-list-of-Srting -> String
; convert List-of-list-of-string
; to one string
 (check-expect (convert (read-words/line "ttt.txt")) (read-file "ttt.txt"))
 (define (convert llstr)
  (cond
    [(empty? (rest llstr)) (convert-line (first llstr))]
    [(cons? llstr)
     (string-append (convert-line (first llstr))
                    "\n"
                    (convert (rest llstr))
                   )
     ]))

; helper function
; List-of-String -> String
; convert one line into words
(check-expect (convert-line
               (cons "hey" (cons "what's" (cons "up?" '()))))
              "hey what's up?")
(define (convert-line ll)
  (cond
    [(empty? (rest ll)) (string-append (first ll) "")]
    [(cons? ll)
     (string-append (first ll) " " (convert-line (rest ll)))]
    ))