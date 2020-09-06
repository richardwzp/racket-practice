;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise_83_6_2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)
; constant definition
(define CANVAS
  (empty-scene 200 20))
(define CURSOR
  (rectangle 1 20 "solid" "red"))
; data definition
(define-struct editor [pre post])
; editor -> Image
; generate the word with curser
; inbetween the two strings
(define (insert-curser p)
   (beside
    (text (editor-pre p) 11 "black")
    CURSOR
    (text (editor-post p) 11 "black")
    )
  )
; editor -> Image
; place the word with curser onto the
; background
(define (render word)
  (overlay/align "left" "center"
   (insert-curser word)
   CANVAS
   )
  )
