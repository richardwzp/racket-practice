;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise_219_7_13) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

; constant
(define MAX 11)
; visual constant
(define DISK (circle 4 "solid" "red"))
(define FOOD (circle 4 "solid" "green"))
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

(define-struct food [x y])
; food is a definition of:
; (make-food Number Number)
; interpretation food rpesents the location of the food

(define-struct game-state [worm food])
; game-state is a definition of:
; (make-game-state List cons)
; interpretation worm represents the worm, and food represent the location of the worm food


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
    [else loc]
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

; List-of-worm -> List-of-worm
; 1: append a new element to the end of the worm
; 2: tick handle for the worm
(check-expect (worm-tock-with-food (list (make-location 20 40 "right") (make-location 28 40 "right") (make-location 36 40 "right")))
              (list (make-location 28 40 "right") (make-location 36 40 "right") (make-location 44 40 "right") (make-location 36 40 "right")))
(define (worm-tock-with-food ws)
  (append (worm-tock-handle ws (location-dir (first ws))) (list (last ws))))

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

; list-of-worm food -> Boolean
; determine if the food is generated on top of the snake
(define (member-of-worm? ws lo)
  (cond
    [(empty? ws) #f]
    [else
     (if (and (= (location-x (first ws)) (location-x lo)) (= (location-y (first ws)) (location-y lo)))
      #t
      (member-of-worm? (rest ws) lo)
      )
     ]
    ))

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
      (member-of-worm? (rest ws) (first ws)))
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
  (if (and (same-axis? ws keystroke) (or (string=? keystroke "right") (string=? keystroke "left") (string=? keystroke "up") (string=? keystroke "down"))) 
      ws
      (cons (make-location (location-x (first ws)) (location-y (first ws)) keystroke) (rest ws))))



; food creation
; food -> food 
; ???
(check-satisfied (food-create (make-food 1 1)) not=-1-1?)
(define (food-create p)
  (food-check-create
     p (make-food (+ (* 8 (random MAX)) 8) (+ (* 8 (random MAX)) 8))))
 
; food food -> Posn 
; generative recursion 
; ???
(define (food-check-create p candidate)
  (if (equal? p candidate) (food-create p) candidate))

; food -> Boolean
; use for testing only 
(define (not=-1-1? p)
  (not (and (= (food-x p) 1) (= (food-y p) 1))))

; list-of-worm food -> Boolean
; determine if the food is generated on top of the snake
(define (member-of-snake? ws fo)
  (cond
    [(empty? ws) #f]
    [else
     (if (and (= (location-x (first ws)) (food-x fo)) (= (location-y (first ws)) (food-y fo)))
      #t
      (member-of-snake? (rest ws) fo)
      )
     ]
    ))

; game-state food -> food
; genearte a food that is not on top of the snake
(define (generate-food gs fo)
  (if (member-of-snake? (game-state-worm gs) fo) (generate-food gs (food-create fo)) fo))

; game-state -> Boolean
; see if the worm consumes the food
; note: in this case, the second var in move-worm does not matter
(check-expect (consumed? (make-game-state (list (make-location 50 50 "right")) (make-food 66 50))) #f)
(check-expect (consumed? (make-game-state (list (make-location 50 50 "right")) (make-food 58 50))) #t)
(define (consumed? gs)
  (if
   (and (= (location-x (move-worm (first (game-state-worm gs)) "right")) (food-x (game-state-food gs)))
        (= (location-y (move-worm (first (game-state-worm gs)) "right")) (food-y (game-state-food gs)))) 
   #t
   #f
   ))

; game-state -> game-state
; tick handle for game
(check-satisfied (worm-game-tock (make-game-state (list (make-location 50 50 "right")) (make-food 50 50))) game-state?)
(define (worm-game-tock ws)
  (if (consumed? ws)
      (make-game-state (worm-tock-with-food (game-state-worm ws)) (generate-food ws (food-create (game-state-food ws))))
      (make-game-state (worm-tock (game-state-worm ws)) (game-state-food ws)) 
      ))

; game-state -> Image
; render image
(check-expect (worm-game-render (make-game-state (list (make-location 50 58 "right")) (make-food 50 50)))
              (place-image FOOD 50 50 (worm-render (list (make-location 50 58 "right")))))
(define (worm-game-render gs)
  (place-image
   FOOD
   (food-x (game-state-food gs)) (food-y (game-state-food gs))
   (worm-render (game-state-worm gs))))

; game-state -> game-state
; key handle
(check-expect (worm-game-key (make-game-state (list (make-location 50 58 "right")) (make-food 50 50)) "up")
              (make-game-state (list (make-location 50 58 "up")) (make-food 50 50)))
(define (worm-game-key gs keystroke)
  (make-game-state (worm-key (game-state-worm gs) keystroke) (game-state-food gs)))

; game-state -> Boolean
; determine if game over
; note: input is modified to take game-state
(check-expect (worm-game-over? (make-game-state (list (make-location 50 101 "right")) (make-food 50 50))) #t)
(check-expect (worm-game-over? (make-game-state (list (make-location 50 50 "right")) (make-food 50 50))) #f)
(define (worm-game-over? gs)
  (game-over? (game-state-worm gs)))

; game-state -> Image
; render last image when program ends
; note: input is modified to take game-state
; note: add the food element
(check-expect (worm-last-scene (make-game-state (list (make-location 50 500 "right")) (make-food 50 50)))
              (place-image
               FOOD
               50 50
               (last-scene (list (make-location 50 500 "right")))))
(define (worm-last-scene gs)
  (place-image FOOD
         (food-x (game-state-food gs)) (food-y (game-state-food gs))
         (last-scene (game-state-worm gs))
         )) 

; List-of-worms -> Image
(define (worm-main ws)
  (big-bang ws
    [to-draw worm-game-render]
    [on-tick worm-game-tock 0.2]
    [on-key worm-game-key]
    [stop-when worm-game-over? worm-last-scene]))

; (worm-main (make-game-state (list (make-location 40 24 "right") (make-location 32 24 "right") (make-location 24 24 "right") (make-location 16 24 "right") (make-location 8 24 "right")) (food-create (make-food 0 0))))