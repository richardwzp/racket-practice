;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise_154_6_17) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; a Russian doll is one of:
; - String
; (make-layer String RD)
(define-struct layer [color doll])
(define ex (make-layer "yellow" (make-layer "blue" (make-layer "red" "green"))))
; Russian doll -> String
; produce a string of all colors, seperated by comma
(check-expect (colors ex) "yellow, blue, red, green")
(define (colors doll)
  (cond
    [(string? doll) doll]
    [(layer? doll) (string-append (layer-color doll) ", " (colors (layer-doll doll)))]
    ))

