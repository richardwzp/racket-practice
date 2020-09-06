;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise_51_5_30) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)
; physical constant definitions
(define LIGHT_RAIDUS 20)
(define GAP (* 0.4 LIGHT_RAIDUS))
(define REDLIGHT_Y
  (+ GAP LIGHT_RAIDUS))
(define YELLOWLIGHT_Y
  (+ (* 2 GAP) (* 3 LIGHT_RAIDUS)))
(define GREENLIGHT_Y
  (+ (* 3 GAP) (* 5 LIGHT_RAIDUS)))
(define BACKBOARD_WIDTH
  (+ GAP (* 2 LIGHT_RAIDUS)))
(define BACKBOARD_HEIGHT
  (+ (* GAP 4) (* 6 LIGHT_RAIDUS)))
(define LIGHT_X (/ BACKBOARD_WIDTH 2))
; graphic constant definitions
(define RED_LIGHT
  (circle LIGHT_RAIDUS "solid" "red"))
(define YELLOW_LIGHT
  (circle LIGHT_RAIDUS "solid" "yellow"))
(define GREEN_LIGHT
  (circle LIGHT_RAIDUS "solid" "green"))
(define NO_LIGHT
  (circle LIGHT_RAIDUS "solid" "dimgrey"))
(define BACKBOARD
  (rectangle BACKBOARD_WIDTH BACKBOARD_HEIGHT "solid" "grey")
  )
(define BACKBOARD_OUTLINE
  (rectangle BACKBOARD_WIDTH BACKBOARD_HEIGHT "outline" "black")
  )
; asembled graphic constant definitions
(define BACKGROUND_1
  (place-image
   BACKBOARD_OUTLINE
   (/ BACKBOARD_WIDTH 2) (/ BACKBOARD_HEIGHT 2)
   BACKBOARD
   )
  )
(define BACKGROUND_2
  (place-image
   NO_LIGHT
   LIGHT_X REDLIGHT_Y
   BACKGROUND_1
   )
  )
(define BACKGROUND_3
  (place-image
   NO_LIGHT
   LIGHT_X YELLOWLIGHT_Y
   BACKGROUND_2
   )
  )
(define BACKGROUND
  (place-image
   NO_LIGHT
   LIGHT_X GREENLIGHT_Y
   BACKGROUND_3
   )
  )
; BIG-BANG FUNCTION SET-UP
; WorldState -> WorldState
; if the state
(check-expect (tock 1) 2)
(check-expect (tock 2) 3)
(check-expect (tock 41) 1)
(define (tock cw)
  (cond
    [(< (+ cw 1) 41) (+ cw 1)]
    [else 1]
    )
   )
; WorldState -> String
; translate WorldState
; into which color should
; the program display
(define (recognize cw)
  (cond
    [(<= cw 10) "red"]
    [(and (> cw 10) (<= cw 20)) "yellow"]
    [(and (> cw 20) (<= cw 30)) "green"]
    [(and (> cw 30) (<= cw 40)) "yellow"]
    )
  )
; String -> Image
; translate light color
; into light image
(define (LIGHT_IMAGE str)
  (cond
    [(string=? str "red") RED_LIGHT]
    [(string=? str "yellow") YELLOW_LIGHT]
    [(string=? str "green") GREEN_LIGHT])
  )
; String -> number
; translate light color
; into y coordinate
(define (LIGHT_Y str)
  (cond
    [(string=? str "red") REDLIGHT_Y]
    [(string=? str "yellow") YELLOWLIGHT_Y]
    [(string=? str "green") GREENLIGHT_Y])
  )
; WorldState -> Image
(define (render cw)
  (place-image
   (LIGHT_IMAGE (recognize cw))
   (/ BACKBOARD_WIDTH 2) (LIGHT_Y (recognize cw))
   BACKGROUND
   )
  )
; main function
(define main
  (big-bang 1
   [on-tick tock]
   [to-draw render]   
      )
  )
