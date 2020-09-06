;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise_109_6_10) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)
; variable definition
(define AA "expect a")
(define BB "expect b , c, or d")
(define DD "finished")
(define ER "error")
; image definition
; Color -> Image
; render a rectangle depend on the color
(check-expect (render_image "red") (empty-scene 100 100 "red"))
(define (render_image color)
  (empty-scene 100 100 color))
; big bang helper functions
; WorldState keystroke -> WorldState
; if a is pressed when the world is at initial state,
; change the state to BB
; if anything else is pressed,
; change the state to ER
(check-expect (key_AA "a") BB)
(check-expect (key_AA "c") ER)
(define (key_AA keystroke)
  (if (string=? keystroke "a") BB ER)
  )
; WorldState keystroke -> WorldState
; if b or c is pressed when the world is at BB state,
; maintain the state at BB
; if d is pressed,
; change the state to DD
; else, change the state to ER
(check-expect (key_BB "a") ER)
(check-expect (key_BB "c") BB)
(check-expect (key_BB "d") DD)
(define (key_BB keystroke)
  (if
   (or (string=? keystroke "b") (string=? keystroke "c"))
   BB
   (if (string=? keystroke "d") DD ER)
   ))
; big bang functions
; WorldState keystroke -> WorldState
(check-expect (KEY AA "a") BB)
(check-expect (KEY BB "b") BB)
(check-expect (KEY DD "a") DD)
(check-expect (KEY ER "a") ER)
(define (KEY cw keystroke)
  (cond
    [(string=? cw AA) (key_AA keystroke)]
    [(string=? cw BB) (key_BB keystroke)]
    [(string=? cw DD) DD]
    [(string=? cw ER) ER]
    ))
; WorldState -> Image
; render image base on given state
(define (render cw)
(cond
    [(string=? cw AA) (render_image "white")]
    [(string=? cw BB) (render_image "yellow")]
    [(string=? cw DD) (render_image "green")]
    [(string=? cw ER) (render_image "red")]
  ))
; main function
(define main
  (big-bang AA
      [to-draw render]
      [on-key KEY]
      ))