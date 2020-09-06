;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise_153_6_17) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
; image constant definition
(define circ (circle 5 "solid" "yellow"))
(define SQUARE (rectangle 10 10 "outline" "black"))
; Natural Number Image -> Image
; consumes a Natural number n and an image,
; produces n copies of the Image horrizontally
(check-expect (row 5 circ) (beside circ circ circ circ circ))
(define (row n img)
  (cond
    [(= n 1) img]
    [(number? n) (beside (row (sub1 n) img) img)]
    ))
; Natural Number Image -> Image
; consumes a Natural number n and an image,
; produces n copies of the Image vertically
(check-expect (col 5 circ) (above circ circ circ circ circ))
(define (col n img)
  (cond
    [(= n 1) img]
    [(number? n) (above (col (sub1 n) img) img)]
    ))
; image definition
(define background
(overlay (col 18 (row 8 SQUARE)) (empty-scene 80 180))
  )
(define red_dot (circle 4 "solid" "red"))
; List-of-posn is one of:
; - (cons posn '())
; - (cons posn List-of-posn)
(define red-dots (cons (make-posn 10 50) (cons (make-posn 20 50) (cons (make-posn 30 50) '()))))
; List-of-posn -> Image
; place red dots on the lecture hall with coordinates
; specified by List-of-posn
(check-expect (add-balloon red-dots) (place-images (make-list 3 red_dot) red-dots background))
(define (add-balloon lpos)
  (cond
    [(empty? (rest lpos))
        (place-image/align
         red_dot
         (posn-x (first lpos)) (posn-y (first lpos))
         "center" "center"
         background)]
    [(cons? lpos)
     (place-image/align
         red_dot
         (posn-x (first lpos)) (posn-y (first lpos))
         "center" "center"
         (add-balloon (rest lpos)))
     ]
    ))
