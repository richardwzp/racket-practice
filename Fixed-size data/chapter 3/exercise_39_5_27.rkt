#lang racket
(require 2htdp/image)
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
