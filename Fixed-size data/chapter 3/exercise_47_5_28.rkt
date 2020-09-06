;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise_47_5_28) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)
(define BACKGROUND
  (rectangle 20 100 "outline" "black"))
(define (BAR PERCENT)
  (rectangle 20 PERCENT "solid" "red"))
; WorldState -> Image
; translate WorldState into
; image
(define (render cw)
  (place-image
   (BAR cw)
   10 (- 100 (/ cw 2))
   BACKGROUND
   )
  )
; WorldState -> WorldState
; with each tick, WorldState
; decrease by 0.1
(define (tock cw)
  (- cw 0.1))
; WorldState -> WorldState
; increase by 1/3, if exceed
; 100, value becomes 100
(define (INC cw)
  (if (<= (+ cw (/ cw 3)) 100)
  (+ cw (/ cw 3))
  100
  ))
; WorldState -> WorldState
; decrease by 1/5, if less than
; 0, value becomes 0
(define (DEC cw)
  (if (>= (- cw (/ cw 5)) 0)
   (- cw (/ cw 5))
   0
  ))
(define (KEY cw KEY_STROKE)
  (cond
    [(key=? KEY_STROKE "up") (INC cw)]
    [(key=? KEY_STROKE "down") (DEC cw)]
    )
   )
; WorldState -> boolean
; if the value hits zero,
; the program stop
(define (PAUSE cw)
  (if (<= cw 0) #true #false))
; WorldState -> animation
(define (main cw)
  (big-bang cw
   [on-tick tock]
   [on-key KEY]
   [to-draw render]
   [stop-when PAUSE]
      )
  )

