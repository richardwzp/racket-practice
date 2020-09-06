;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise_111_6_13) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct vec [x y])
; A vec is
;   (make-vec PositiveNumber PositiveNumber)
; interpretation represents a velocity vector
; ANY -> ???
; check if both inputs are positive number
(define MESSAGE "make-vec: input must be posn")
(define MESSAGE-2 "make-vec: input must be positive number")
(define (check-make-vec v)
  (cond
    [(vec? v)
     (if (and (> (vec-x v) 0) (> (vec-y v) 0)) v (error MESSAGE-2))]
    [else (error MESSAGE)]


    )
  )