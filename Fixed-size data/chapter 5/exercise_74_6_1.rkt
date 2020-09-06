;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise_74_6_1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)
; constant definition
(define canvas
  (rectangle 30 30 "outline" "black"))
(define red_dot
  (circle 2 "solid" "red"))
; WorldState -> Image
(check-expect
 (render (make-posn 4 4))
 (place-image red_dot 4 4 canvas)
 )
(define (render cw_p)
  (place-image
   red_dot
   (posn-x cw_p) (posn-y cw_p)
   canvas
   )
  )
; posn Number Number KeyEvent -> posn
; if down button is pressed,
; the dot is reset
(check-expect
 (reset-dot (make-posn 12 12) 15 15 "button-down")
 (make-posn 15 15)
 )
(check-expect
 (reset-dot (make-posn 12 12) 15 15 "button-up")
 (make-posn 12 12)
 )
(define (reset-dot p x y me)
  (cond
    [(mouse=? me "button-down") (make-posn x y)]
    [else p]))
(define main
  (big-bang (make-posn 15 15)
  [to-draw render]
  [on-mouse reset-dot]
       )
  )