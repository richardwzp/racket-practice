;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise_177_7_1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(define-struct editor [pre post])
; An Editor is a structure:
;   (make-editor Lo1S Lo1S) 
; An Lo1S is one of: 
; – '()
; – (cons 1String Lo1S)
(define CANVAS
  (empty-scene 200 20))
(define CURSOR
  (rectangle 1 20 "solid" "red"))
; create-editor helper
; String -> List
; convert a string to a list
(check-expect (string_to_list "abc") (cons "a" (cons "b" (cons "c" '()))))
(define (string_to_list l)
  (cond
    [(string=? l "") '()]
    [else
     (cons (string-ith l 0) (string_to_list (substring l 1 (string-length l))))
     ]))
; String String -> editor
; consume two strings and create an editor
(check-expect (create-editor "ab" "cd")
              (make-editor
               (cons "a" (cons "b" '()))
               (cons "c" (cons "d" '()))))
(define (create-editor str1 str2)
  (make-editor
   (string_to_list str1)
   (string_to_list str2)
   ))