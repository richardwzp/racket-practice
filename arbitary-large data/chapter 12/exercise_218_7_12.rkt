;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise_218_7_12) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

; visual constant
(define DISK (circle 4 "solid" "red"))
(define CANVAS (empty-scene 104 104))

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

; List-of-worms -> Boolean
; determine if the worm hit the boarder
(check-expect (hit-boarder? (list (make-location 50 101 "right"))) #t)
(check-expect (hit-boarder? (list (make-location 50 50 "right"))) #f)
(define (hit-boarder? ws)
  (if
     (or
      (> (location-x (first ws)) 100)
      (< (location-x (first ws)) 0)
      (> (location-y (first ws)) 100)
      (< (location-y (first ws)) 0))
     #t
     #f))

; helper function
; list -> element
; retrieve the last item of the list
(check-expect (last (list 1 2 3 4 5)) 5)
(define (last ls)
  (cond
    [(empty? (rest ls)) (first ls)]
    [else (last (rest ls))]))

; List-of-worms -> Boolean
; determine if the worm ended itself
(check-expect (game-over? (list (make-location 50 101 "right"))) #t)
(check-expect (game-over? (list (make-location 50 50 "right"))) #f)
(define (game-over? ws)
  (if
     (or
      (> (location-x (first ws)) 100)
      (< (location-x (first ws)) 0)
      (> (location-y (first ws)) 100)
      (< (location-y (first ws)) 0)
      (and (= (location-x (first ws)) (location-x (last ws)))
           (= (location-y (first ws)) (location-y (last ws)))
           (> (length ws) 1)))
     #t
     #f))

; List-of-worms -> Image
; render last scene with the caption,
; hit boarder
(define BOARDER-MESSAGE (text "hit boarder" 10 "black"))
(define ONESELF-MESSAGE (text "hit the tail" 10 "black"))
(check-expect (last-scene (list (make-location 50 500 "right")))
              (place-image
               BOARDER-MESSAGE
               65 75
               (worm-render (list (make-location 50 500 "right")))))
(define (last-scene ws)
  (place-image
               (if (hit-boarder? ws) BOARDER-MESSAGE ONESELF-MESSAGE)
               65 75
               (worm-render ws)))

; list-of-worms String -> boolean
; determine if keystroke is illegal direction
; example: pressing left arrow while the snake is going to the right
(check-expect (same-axis? (list (make-location 50 50 "right")) "left") #t)
(check-expect (same-axis? (list (make-location 50 50 "right")) "top") #f)
(define (same-axis? ws keystroke)
  (cond
    [(and (string=? (location-dir (first ws)) "right") (string=? keystroke "left")) #t]
    [(and (string=? (location-dir (first ws)) "left") (string=? keystroke "right")) #t]
    [(and (string=? (location-dir (first ws)) "up") (string=? keystroke "down")) #t]
    [(and (string=? (location-dir (first ws)) "down") (string=? keystroke "up")) #t]
    [else #f]
    ))

; list-of-worms String -> list-of-worms
(check-expect (worm-key (list (make-location 50 50 "right")) "left") (list (make-location 50 50 "right")))
(check-expect (worm-key (list (make-location 50 50 "right")) "down") (list (make-location 50 50 "down")))
(define (worm-key ws keystroke)
  (if (same-axis? ws keystroke) 
      ws
      (cons (make-location (location-x (first ws)) (location-y (first ws)) keystroke) (rest ws))))

; List-of-worms -> Image
(define (worm-main ws)
  (big-bang ws
    [to-draw worm-render]
    [on-tick worm-tock 1]
    [on-key worm-key]
    [stop-when game-over? last-scene]))

; (worm-main (list (make-location 40 20 "right") (make-location 32 20 "right") (make-location 24 20 "right") (make-location 16 20 "right") (make-location 8 20 "right")))