;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise_110_6_13) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Number -> Number
; computes the area of a disk with radius r
(define (area-of-disk r)
  (* 3.14 (* r r)))

; Any -> ???
(define MESSAGE "area-of-disk: number expected")
(define MESSAGE-2 "area-of-disk: positive number expected")
(define (check-area-of-disk v)
  (cond
    [(number? v)
     (if (> v 0) (area-of-disk v) (error MESSAGE-2))
     ]
    [else (error MESSAGE)]
    )
  )