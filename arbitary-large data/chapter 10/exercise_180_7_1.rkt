;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise_180_7_1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(define FONT-SIZE 11)
(define FONT-COLOR "black")
; editor-render helper function
; Lo1s -> Image
; renders a list of 1Strings as a text image
(check-expect
  (editor-text
   (cons "p" (cons "o" (cons "s" (cons "t" '())))))
  (text "post" FONT-SIZE FONT-COLOR))
(define (editor-text s)
  (cond
    [(empty? s) (text "" FONT-SIZE FONT-COLOR)]
    [else
     (beside
      (text (first s) FONT-SIZE FONT-COLOR)
      (editor-text (rest s)))
     ]))