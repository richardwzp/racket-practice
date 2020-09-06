;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise_215_7_12) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

; visual constant
(define DISK (circle 4 "solid" "red"))
(define CANVAS (empty-scene 100 100))

; data definition
; location is a defintion of:
; (make location Number Number String)
; interpretation it represent the relative location of the worm body,
; and the location of the previous worm body
(define-struct location [x y dir])
; A list-of-worm is one of:
; - location
; (cons location list-of-worm)
; interpretation it represents the interactive body of worm

; List-of-worms -> Image
; render the worm body onto the canvas
(check-expect
 (worm-render
  (list (make-location 20 40 "right") (make-location 28 40 "right") (make-location 36 40 "right")))
 (place-image (beside DISK DISK DISK) 28 40 CANVAS))
(define (worm-render ws)
  (cond
    [(empty? ws) CANVAS]
    [else
     (place-image
      DISK
      (location-x (first ws))
      (location-y (first ws))
      (worm-render (rest ws)))
     ]))

; location -> location
; move the DISK by 1 tick
(check-expect (move-worm (make-location 20 40 "right") "right") (make-location 28 40 "right"))
(check-expect (move-worm (make-location 20 40 "left") "left") (make-location 12 40 "left"))
(check-expect (move-worm (make-location 20 40 "up") "up") (make-location 20 32 "up"))
(check-expect (move-worm (make-location 20 40 "down") "down") (make-location 20 48 "down"))
(define (move-worm loc ins)
  (cond
    [(string=? (location-dir loc) "right") (make-location (+ (location-x loc) 8) (location-y loc) ins)]
    [(string=? (location-dir loc) "left") (make-location (- (location-x loc) 8) (location-y loc) ins)]
    [(string=? (location-dir loc) "up") (make-location (location-x loc) (- (location-y loc) 8)  ins)]
    [(string=? (location-dir loc) "down") (make-location (location-x loc) (+ (location-y loc) 8) ins)]
    ))

; List-of-worms -> List-of-worms
; clock handler for mdofiying the list
(check-expect (worm-tock-handle (list (make-location 20 40 "right") (make-location 28 40 "right") (make-location 36 40 "right")) "top")
              (list (make-location 28 40 "top") (make-location 36 40 "right") (make-location 44 40 "right")))
(define (worm-tock-handle ws ins)
  (cond
    [(empty? ws) '()]
    [else (cons (move-worm (first ws) ins) (worm-tock-handle (rest ws) (location-dir (first ws))))]
    ))

; List-of-worms -> List-of-worms
(check-expect (worm-tock (list (make-location 20 40 "right") (make-location 28 40 "right") (make-location 36 40 "right")))
              (list (make-location 28 40 "right") (make-location 36 40 "right") (make-location 44 40 "right")))
(define (worm-tock ws)
  (worm-tock-handle ws (location-dir (first ws))))

(define (worm-key ws keystroke) ...)

; List-of-worms -> Image
(define (worm-main ws)
  (big-bang ws
    [to-draw worm-render]
    [on-tick worm-tock 1]))

