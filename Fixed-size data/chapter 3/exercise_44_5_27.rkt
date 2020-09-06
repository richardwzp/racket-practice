;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise_44_5_27) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;#lang racket
(require 2htdp/image)
(require 2htdp/universe)
;physical attributes
(define WHEEL_RADIUS 5)
(define WHEEL_DISTANCE (* WHEEL_RADIUS 5))
;image rendition
(define WHEEL
  (circle WHEEL_RADIUS "solid" "black"))
(define CAR_BODY
  (rectangle (* 9 WHEEL_RADIUS) (* 2 WHEEL_RADIUS)  "solid" "red") )
(define CAR_TOP
  (rectangle (* 5 WHEEL_RADIUS) (* 2 WHEEL_RADIUS)  "solid" "red") )
  
; put on wheel onto the car body
(define CAR_ASSEMBLE_1
  (underlay/xy
   CAR_BODY
   WHEEL_RADIUS WHEEL_RADIUS
   WHEEL
   )
  )
; put the second wheel onto the car body
(define CAR_ASSEMBLE_2
  (underlay/xy
   CAR_ASSEMBLE_1
   (* WHEEL_RADIUS 6) WHEEL_RADIUS 
   WHEEL
   )
  )
; puting the car top on(final step)
(define CAR
  (underlay/xy
   CAR_ASSEMBLE_2
   (* WHEEL_RADIUS 2) (* WHEEL_RADIUS -1)
   CAR_TOP
   )
  )
; background canvas
(define WORLD_LENGTH (* WHEEL_RADIUS 80))
(define WORLD_HEIGHT (* WHEEL_RADIUS 5))
(define tree
  (underlay/xy (circle 10 "solid" "green")
               9 15
               (rectangle 2 20 "solid" "brown")))
(define CANVAS
  (rectangle
   WORLD_LENGTH WORLD_HEIGHT
   "outline"
   "black"
   ))
(define BACKGROUND
  (place-image
   tree
   (/ WORLD_LENGTH 2) (- 20 (/ WORLD_HEIGHT 2))
   CANVAS
   )
  )
; WorldState -> WorldState 
; moves the car by 3 pixels for every clock tick
; examples: 
;   given: 20, expect 23
;   given: 78, expect 81
(check-expect (tock 20) 23)
(define (tock cw)
  (+ cw 3))
; y coordinate of car
(define Y_CAR (* WHEEL_RADIUS 3))
; WorldState -> Image
; place CAR on BACKGROUND with respect to WorldState
(define (render cw)
  (place-image CAR cw Y_CAR BACKGROUND))
; WorldState -> boolean
; determine if the WorldState is greater
; than 740, stop
(define (WORLD_COND ws)
  (if (<= ws (- WORLD_LENGTH (* WHEEL_RADIUS 4))) #false #true)
  )
; WorldState Number Number String -> WorldState
; places the car at x-mouse
; if the given me is "button-down" 
(define (hyper x-position-of-car x-mouse y-mouse me)
  (cond
    [(string=? "button-down" me) x-mouse]
    [else x-position-of-car]))
; WorldState -> WorldState
; launches the program from some initial state
(define (main ws)
  (big-bang ws
    [on-tick tock]
    [to-draw render]
    [stop-when WORLD_COND]
    [on-mouse hyper]
    )
  )
