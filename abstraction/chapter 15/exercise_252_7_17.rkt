;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise_252_7_17) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; [item item -> Result] Result [List-of item] -> Result
(define (fold2 f end l)
  (cond
    [(empty? l) end]
    [else
     (f (first l)
        (fold2
          f end (rest l)))]))