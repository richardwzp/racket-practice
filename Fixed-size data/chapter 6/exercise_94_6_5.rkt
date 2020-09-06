;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise_94_6_5) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)
; data definition
; (make-game_state Number UFO MISSLE)
; first element represents the position of the tank
; second element represents xy coordinates of UFO
; third element represents xy coordinates of the MISSLE
(define-struct game_state [tank_x UFO MISSLE])
; (make-UFO Number Number)
; the two numbers represent the x y, coordinate of UFO
(define-struct UFO [x y])
; (make_MISSLE Number Number)
; the two numbers represent the x y, coordinate of MISSLE
(define-struct MISSLE [x y])
; example game_state definition
(define t
(make-game_state
   200
   (make-UFO 20 30)
   (make-MISSLE 40 10))
 )
; constant definition
(define game_width 800)
(define game_height 300)
(define missle_width 4)
(define missle_length 10)
; the mmaximum distance of collision between missle and ufo
(define collide_d 10)
; image definition
(define outbound
  (empty-scene game_width game_height))
(define ground
  (rectangle game_width 50 "solid" "brown"))
; background of the game
(define background (overlay/align
 "middle" "bottom"
 ground
 outbound
 ))
; game element definition
(define tank
  (triangle 15 "solid" "red"))
(define missle
  (rectangle missle_width missle_length "solid" "red"))
(define ufo
  (ellipse 40 20 "solid" "green"))
; game_state -> posn
; extract game_state,
; return a posn that includes
; coordinate of the missle
(check-expect (get_missle t) (make-posn 40 10))
(define (get_missle g)
  (make-posn
   (MISSLE-x (game_state-MISSLE g))
   (MISSLE-y (game_state-MISSLE g))
   ))
; game_state -> Number
; get the x coord of MISSLE
(check-expect (get_missle_x t) 40)
(define (get_missle_x g)
  (posn-x (get_missle g))
  )
; game_state -> Number
; get the y coord of MISSLE
(check-expect (get_missle_y t) 10)
(define (get_missle_y g)
  (posn-y (get_missle g))
  )
; game_state -> posn
; extract game_state,
; return a posn that includes
; coordinate of the UFO
(check-expect (get_ufo t) (make-posn 20 30))
(define (get_ufo g)
 (make-posn
  (UFO-x (game_state-UFO g))
  (UFO-y (game_state-UFO g))
  ))
; game_state -> Number
; get the x coord of UFO
(check-expect (get_ufo_x t) 20)
(define (get_ufo_x g)
  (posn-x (get_ufo g))
  )
; game_state -> Number
; get the y coord of UFO
(check-expect (get_ufo_y t) 30)
(define (get_ufo_y g)
  (posn-y (get_ufo g))
  )
; game_state -> Number
; calculate the distance between missle and ufo
; Sqrt(delta_x^2 + delta_y*2)
(check-within (dist t) (sqrt 800) 0.1)
(define (dist g)
  (sqrt
   (+ (expt
       (- (get_missle_x g) (get_ufo_x g))
       2)
      (expt
       (- (get_missle_y g) (get_ufo_y g))
       2))
   ))
