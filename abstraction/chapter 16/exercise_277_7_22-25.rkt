;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_277_7_22-25) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

; constant
(define WIDTH 200)
; graphic constant
(define CANVAS (empty-scene WIDTH WIDTH))
(define UFO (ellipse 20 10 "solid" "red"))
(define TANK (rectangle 20 10 "solid" "blue"))
(define SHOT (rectangle 5 10 "solid" "blue"))
(define BOMB (ellipse 5 10 "solid" "brown"))



; a shot is a structure of:
; - (make N N)
; interpretation the x and y coordinate of the shot
(define-struct shot [x y])

; data definition
; a tank is a structure of:
; - Number [list-of shot]
; the number represent the X coordinate,
; the list of shot keep tracks of the missle filed
(define-struct tank [x shot])

; a bomb is a structure of:
; - (make N N)
; interpretation the x and y coordinate of the bomb
(define-struct bomb [x y])

; a ufo is a structure of:
; - (make N N bomb String)
; interpretation the x and y coordinate of the ufo,
; list of bomb keeps track of the list of bomb being dropped
; the string tracks the direction of the ufo
(define-struct ufo [x y bomb direction])

; a game-state is a structure of:
; - (make tank [list-of ufo] N)
; the first two are tank and ufo, with the last number being tick tracker
(define-struct game-state [tank ufo timer])

; auxiliary functions
; posn posn -> Boolean
; determine if the distance between is too close or not
(check-expect (close? (make-posn 3 0) (make-posn 0 4)) #t)
(define (close? p1 p2)
  (<= (sqrt
   (+ (expt (- (posn-y p1) (posn-y p2)) 2)
      (expt (- (posn-x p1) (posn-x p2)) 2)
    )) 7))

; shot -> posn
; turn shot into x y coordinate
(check-expect (shot-posn (make-shot 10 15)) (make-posn 10 15))
(define (shot-posn s)
  (make-posn (shot-x s) (shot-y s)))
; ufo -> posn
; turn ufo into x y coordinate
(check-expect (ufo-posn (make-ufo 10 15 '() "left")) (make-posn 10 15))
(define (ufo-posn u)
  (make-posn (ufo-x u) (ufo-y u)))
; tank -> posn
; turn tank into x y coordinate
(check-expect (tank-posn (make-tank 10 '())) (make-posn 10 (- WIDTH 5)))
(define (tank-posn t)
  (make-posn (tank-x t) (- WIDTH 5)))
; bomb -> posn
; turn bomb into x y coordinate
(check-expect (bomb-posn (make-bomb 10 15)) (make-posn 10 15))
(define (bomb-posn b)
  (make-posn (bomb-x b) (bomb-y b)))

; [X] X -> posn
; turn x into a posn
(check-satisfied (turn-posn (make-shot 1 2)) posn?)
(check-satisfied (turn-posn (make-ufo 1 2 '() "right")) posn?)
(check-satisfied (turn-posn (make-tank 1 2)) posn?)
(check-satisfied (turn-posn (make-bomb 1 2)) posn?)
(check-satisfied (turn-posn (make-posn 1 2)) posn?)

(define (turn-posn x)
  (cond
    [(shot? x) (shot-posn x)]
    [(ufo? x) (ufo-posn x)]
    [(tank? x) (tank-posn x)]
    [(bomb? x) (bomb-posn x)]
    [(posn? x) x]
    ))

; [X Y] X -> Boolean
; see if the two objects are close enough
(check-expect (close-contact? (make-shot 0 3) (make-ufo 4 0 '() "right")) #t)
(check-expect (close-contact? (make-shot 0 3) '()) #f)
(define (close-contact? x y)
  (cond
    [(or (empty? x) (empty? y)) #f]
    [else (close? (turn-posn x) (turn-posn y))]))

; tank

; tank -> tank
; move the shots if there's any
(check-expect (tank-tock (make-tank 10 `(,(make-shot 10 30) ,(make-shot 30 45) ,(make-shot 20 3)))) (make-tank 10 `(,(make-shot 10 28) ,(make-shot 30 43))))
(check-expect (tank-tock (make-tank 10 '())) (make-tank 10 '()))
(define (tank-tock t)
  (local
    (; filter the list, eliminate unecessary shot
     (define filtered-tankshot (filter (lambda (x) (> (shot-y x) 5)) (tank-shot t))))
    
    (cond
    [(empty? filtered-tankshot) (make-tank (tank-x t) '())]
    [else
     (make-tank (tank-x t) (map (lambda (x) (make-shot (shot-x x) (- (shot-y x) 2))) filtered-tankshot))
     ])))

; tank -> [list-of shot]
; add a shot to list
(check-expect (shot-fired (make-tank 10 '())) `(,(make-shot 10 (- WIDTH 8))))
(define (shot-fired t)
  (cons (make-shot (tank-x t) (- WIDTH 8)) (tank-shot t)))

; tank keystroke -> tank
; move the tank according to key
(define MOVEMENT 6)
(check-expect (tank-key (make-tank 10 '()) "left") (make-tank (- 10 MOVEMENT) '()))
(check-expect (tank-key (make-tank 10 '()) "right") (make-tank (+ 10 MOVEMENT) '()))
(check-expect (tank-key (make-tank (- WIDTH 5) '()) "right") (make-tank (- WIDTH 5) '()))
(check-expect (tank-key (make-tank (- WIDTH 5) '()) " ") (make-tank (- WIDTH 5) `(,(make-shot (- WIDTH 5) (- WIDTH 8)))))
(define (tank-key t keystroke)
  (cond
    [(and (string=? keystroke "left") (> (tank-x t) 5)) (make-tank (- (tank-x t) MOVEMENT) (tank-shot t))]
    [(and (string=? keystroke "right") (< (tank-x t) (- WIDTH 5))) (make-tank (+ (tank-x t) MOVEMENT) (tank-shot t))]
    [(string=? keystroke " ") (make-tank (tank-x t) (shot-fired t))]
    [else t]
    ))

; tank Image -> Image
; render the tank into an image
(check-expect (tank-render (make-tank 10 '()) CANVAS) (place-image TANK 10 (- WIDTH 5) CANVAS))
(check-expect (tank-render (make-tank 10 `(,(make-shot 50 20))) CANVAS) (place-image TANK 10 (- WIDTH 5) (place-image SHOT 50 20 CANVAS)))
(define (tank-render t img)
  (local
    (; [list-of shot] Image -> Image
     ; render the shots
     (define (shot-render s base)
       (place-image SHOT (shot-x s) (shot-y s) base)))
    (place-image
     TANK
     (tank-x t)
     (- WIDTH 5)
     (foldr shot-render img (tank-shot t))
     )))


; ufo
; ufo Image -> Image
; render the ufo into an image
(check-expect (ufo-render `(,(make-ufo 10 50 '() "right")) CANVAS) (place-image UFO 10 50 CANVAS))
(check-expect (ufo-render `(,(make-ufo 10 50 (make-bomb 50 20) "right")) CANVAS) (place-image UFO 10 50 (place-image BOMB 50 20 CANVAS)))
(define (ufo-render u img)
  (local
    (; [list-of shot] Image -> Image
     ; render the shots
     (define (bomb-render b base)
       (if (empty? b) base (place-image BOMB (bomb-x b) (bomb-y b) base)))
     ; [list-of ufo] Image -> Image
     (define (render-ufo uf base) (place-image
     UFO
     (ufo-x uf)
     (ufo-y uf)
     (bomb-render (ufo-bomb uf) base)
     ))
     )
    (foldr render-ufo img u)
    ))
; generate a random number for y axis movement
(check-random (RANDOM_NUMBER 1) (- (random 4) 2))
(define (RANDOM_NUMBER n) (- (random 4) 2))

; [list-of ufo] -> [list-of ufo]
; tick control
; the ufo randomly move left and right and down
(check-satisfied (ufo-tock `(,(make-ufo 4 10 '() "left") ,(make-ufo 10 5 '() "right"))) cons?)
(check-satisfied (ufo-tock `(,(make-ufo 5 10 (make-bomb 5 (- WIDTH 1)) "left") ,(make-ufo 10 5 '() "left"))) cons?)
(check-satisfied (ufo-tock `(,(make-ufo 5 2 (make-bomb 5 100) "left") ,(make-ufo 10 5 '() "right"))) cons?)
(check-satisfied (ufo-tock `(,(make-ufo 5 10 (make-bomb 5 100) "right") ,(make-ufo 10 5 '() "right"))) cons?)
(check-satisfied (ufo-tock `(,(make-ufo (- WIDTH 2) 10 (make-bomb 5 199) "right") ,(make-ufo 10 5 '() "left"))) cons?)
(define (ufo-tock u)
  (local
    (; bomb ufo -> bomb?
     ; randomly determine if a bomb should be generated for ufo
     (define (bomb-process b mu)
       (cond
         [(empty? b) (make-bomb (ufo-x mu) (ufo-y mu))]
         [(> (bomb-y b) (- WIDTH 2)) '()]
         [else (make-bomb (bomb-x b) (+ (bomb-y b) 2))]
         ))
     ; Number Number -> Number
     ; make sure random number wouldn't exceed boundary
     (define (add-to-x n1 n2)
       (cond [(> 5 n1) (if (> n2 0) (+ n1 n2) n1)]
             [(> n1 (- WIDTH 5)) (if (< n2 0) (+ n1 n2) n1)]
             [else (+ n1 n2)]))
     ; ufo 
     ; move a single ufo
     (define (move-ufo mu)
       (make-ufo (add-to-x (ufo-x mu) (if (string=? (ufo-direction mu) "right") 1 -1))
                 (+ (ufo-y mu) 0.4)
                 (bomb-process (ufo-bomb mu) mu)
                 (if (<= 5 (ufo-x mu) (- WIDTH 5))
                     (ufo-direction mu) (if (>= (ufo-x mu) (- WIDTH 5)) "left" "right")))
                  ))
    
    (map move-ufo u)
    ))

; main
; game-state -> Image
; render game state into image
(check-satisfied
 (game-render (make-game-state (make-tank 5 '()) `(,(make-ufo 20 10 '() "right")) 5))
 image?
 )
(define (game-render gs)
  (ufo-render
   (game-state-ufo gs)
   (tank-render (game-state-tank gs) CANVAS)
   ))

; [list-of ufo] [list-of shot] -> [list-of ufo]
; eliminate if ufo is too close
(check-expect (ufo-elim `(,(make-ufo 20 30 '() "right") ,(make-ufo 30 50 '() "right")) `(,(make-shot 20 30))) `(,(make-ufo 30 50 '() "right")))
(define (ufo-elim u los)
  (filter
   (lambda
       (x)
       (not (ormap (lambda (y) (close-contact? x y)) los)))
   u))

; [list-of ufo] Number -> [list-of ufo]
(check-satisfied (ufo-generate `(,(make-ufo 20 30 '() "right") ,(make-ufo 30 50 '() "right")) 30) cons?)
(check-random (ufo-generate `(,(make-ufo 20 30 '() "right") ,(make-ufo 30 50 '() "right")) 9) `(,(make-ufo 20 30 '() "right") ,(make-ufo 30 50 '() "right")))
(define (ufo-generate lou t)
  (if (= (remainder t 30) 0)
      (cons (make-ufo (+ 5 (random (- WIDTH 10))) 5 '() (if (= 0 (random 2)) "right" "left")) lou)
      lou
      ))

; game-state -> game-state
; tick handler
(check-satisfied (game-tock (make-game-state (make-tank 5 '()) `(,(make-ufo 20 10 '() "right")) 5))
              game-state?)
(define (game-tock gs)
  (make-game-state
   (tank-tock (game-state-tank gs))
   (ufo-generate (ufo-elim (ufo-tock (game-state-ufo gs)) (tank-shot (game-state-tank gs))) (game-state-timer gs))
   (+ 1 (game-state-timer gs))
   ))

; game-state keystroke -> game-state
; keyEvent handler
(check-satisfied (game-key (make-game-state (make-tank 5 '()) `(,(make-ufo 20 10 '() "right")) 5) "left")
              game-state?)
(define (game-key gs keystroke)
  (make-game-state
   (tank-key (game-state-tank gs) keystroke)
   (game-state-ufo gs)
   (game-state-timer gs))
   )

; game-state -> Boolean
; check if game ends
(check-expect (game-end? (make-game-state (make-tank 20 '()) `(,(make-ufo 50 5 `() "right") ,(make-ufo 150 5 `() "right")) 5)) #f)
(check-expect (game-end? (make-game-state (make-tank 20 '()) `(,(make-ufo 50 199 `() "right") ,(make-ufo 150 5 `() "right")) 5)) #t)
(check-expect (game-end? (make-game-state (make-tank 20 '()) `(,(make-ufo 50 199 `() "right") ,(make-ufo 150 5 (make-bomb 20 195) "right")) 5)) #t)
(define (game-end? gs)
  (cond
    [(ormap
      (lambda (x) (close-contact? (ufo-bomb x) (game-state-tank gs)))
      (game-state-ufo gs)) #t]
    [(ormap (lambda (x) (> (ufo-y x) (- WIDTH 5))) (game-state-ufo gs)) #t]
    [else #f]))

; game-state -> String
; determine what message to produce
(check-expect (message (make-game-state (make-tank 20 '()) `(,(make-ufo 50 199 `() "right") ,(make-ufo 150 5 `() "right")) 5)) "UFO landed on the surface.")
(check-expect (message (make-game-state (make-tank 20 '()) `(,(make-ufo 50 199 `() "right") ,(make-ufo 150 5 (make-bomb 20 195) "right")) 5)) "the tank is busted by the laser.")
(define (message gs)
   (local
    (; different message
     (define TANK_BUST "the tank is busted by the laser.")
     (define UFO_LAND "UFO landed on the surface."))
    (cond
      [(ormap
      (lambda (x) (close-contact? (ufo-bomb x) (game-state-tank gs)))
      (game-state-ufo gs)) TANK_BUST]
      [(ormap (lambda (x) (> (ufo-y x) (- WIDTH 5))) (game-state-ufo gs)) UFO_LAND]
      )
    ))

; game-state -> Image
; last scene
(check-expect (last-scene (make-game-state (make-tank 20 '()) `(,(make-ufo 50 199 `() "right") ,(make-ufo 150 5 `() "right")) 5))
              (overlay
               (text "UFO landed on the surface." 14 "olive")
               (game-render (make-game-state (make-tank 20 '()) `(,(make-ufo 50 199 `() "right") ,(make-ufo 150 5 `() "right")) 5))))
(check-expect (last-scene (make-game-state (make-tank 20 '()) `(,(make-ufo 50 199 `() "right") ,(make-ufo 150 5 (make-bomb 20 195) "right")) 5))
              (overlay
               (text "the tank is busted by the laser." 14 "olive")
               (game-render (make-game-state (make-tank 20 '()) `(,(make-ufo 50 199 `() "right") ,(make-ufo 150 5 (make-bomb 20 195) "right")) 5))))
(define (last-scene gs)
  (overlay
   (text (message gs) 14 "olive")
   (game-render gs)
           ))

; game-state -> big bang
; main function
(define ex (make-game-state (make-tank 20 '()) `(,(make-ufo 50 5 `() "right") ,(make-ufo 150 5 `() "right")) 5))
(check-satisfied (main ex) game-state?)
(define (main gs)
  (big-bang gs
    [to-draw game-render]
    [on-key game-key]
    [on-tick game-tock]
    [stop-when game-end? last-scene]))




