;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise_190_7_2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; prefixes helper function
; List-of-1string -> List-of-1string
; remove the last item
(check-expect (cut-tail (list "a" "b" "c")) (list "a" "b"))
(define (cut-tail lstr)
  (cond
    [(empty? (rest lstr)) '()]
    [(cons? lstr)
     (cons (first lstr) (cut-tail (rest lstr)))]
    ))

; List-of-1string -> List-of-prefix
; produce all possibility of prefix
(check-expect (prefixes (list "a" "b" "c"))
              (list
               (list "a" "b" "c")
               (list "a" "b")
               (list "a")
               ))
(define (prefixes lstr)
  (cond
    [(empty? lstr) '()]
    [(cons? lstr)
     (cons lstr (prefixes (cut-tail lstr)))]
    ))

; List-of-1string -> List-of-prefix
; produce all possibility of prefix
(check-expect (suffix (list "a" "b" "c"))
              (list
               (list "a" "b" "c")
                   (list "b" "c")
                       (list "c")
               ))
(define (suffix lstr)
  (cond
    [(empty? lstr) '()]
    [(cons? lstr)
     (cons lstr (suffix (rest lstr)))]
    ))