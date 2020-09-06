;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |exercise_102_(space_invader)_6_6|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)
; data definition
; (make-game_state Number UFO)
; unfired state
; first element represents the position of the tank
; second element represents xy coordinates of UFO
(define-struct aim [TANK UFO])
; (make-game_state Number UFO MISSLE)
; first element represents the position of the tank
; second element represents xy coordinates of UFO
; third element represents xy coordinates of the MISSLE
(define-struct fired [TANK UFO MISSLE])
; (make-SIG aim fired)
; first element is the aim state of the game
; second element is the fired state of the game
(define-struct SIG [aim fired])
; (make-UFO Number Number)
; the two numbers represent the x y, coordinate of UFO
(define-struct UFO [x y])
; (make_MISSLE Number Number)
; the two numbers represent the x y, coordinate of MISSLE
(define-struct MISSLE [x y])
; (make-UFO Number Number)
; x represent horizontal position of tank,
; dx represents the speed of tank
(define-struct TANK [x dx])
; missle not fired example
; example fired definition
(define fired_T
(make-fired
   (make-TANK 200 1)
   (make-UFO 20 30)
   (make-MISSLE 0 0))
 )
; example aim definition
(define aim_T
(make-aim
   (make-TANK 200 1)
   (make-UFO 20 30)
 ))
; example SIG definition
(define T (make-SIG aim_T fired_T))
; example: missle fired
; example fired definition
(define fired_t
(make-fired
   (make-TANK 200 1)
   (make-UFO 20 30)
   (make-MISSLE 40 10))
 )
; example aim definition
(define aim_t
(make-aim
   (make-TANK 200 1)
   (make-UFO 20 30)
 ))
; example SIG definition
(define t (make-SIG aim_t fired_t))
; constant definition
(define game_width 800)
(define game_height 300)
(define missle_width 4)
(define missle_length 10)
(define ufo_speed 1)
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
; AUXILARY FUNCTIONS
; fired -> posn
; extract fired,
; return a posn that includes
; coordinate of the missle
(check-expect (get_missle fired_t) (make-posn 40 10))
(define (get_missle g)
  (make-posn
   (MISSLE-x (fired-MISSLE g))
   (MISSLE-y (fired-MISSLE g))
   ))
; fired -> Number
; get the x coord of MISSLE
(check-expect (get_missle_x fired_t) 40)
(define (get_missle_x g)
  (posn-x (get_missle g))
  )
; fired -> Number
; get the y coord of MISSLE
(check-expect (get_missle_y fired_t) 10)
(define (get_missle_y g)
  (posn-y (get_missle g))
  )
; fired -> posn
; extract game_state,
; return a posn that includes
; coordinate of the UFO
(check-expect (get_ufo fired_t) (make-posn 20 30))
(define (get_ufo g)
 (make-posn
  (UFO-x (fired-UFO g))
  (UFO-y (fired-UFO g))
  ))
; SIG -> MISSLE
; get MISSLE from SIG
(check-expect (sig_fired_get_missle T) (make-MISSLE 0 0))
(define (sig_fired_get_missle sig)
  (fired-MISSLE (SIG-fired sig)))
; fired -> Number
; get the x coord of UFO
(check-expect (get_ufo_x fired_t) 20)
(define (get_ufo_x g)
  (posn-x (get_ufo g))
  )
; fired -> Number
; get the y coord of UFO
(check-expect (get_ufo_y fired_t) 30)
(define (get_ufo_y g)
  (posn-y (get_ufo g))
  )
; SIG -> UFO
; get UFO from SIG
(check-expect (sig_fired_get_ufo t) (make-UFO 20 30))
(define (sig_fired_get_ufo sig)
  (fired-UFO (SIG-fired sig)))
; fired -> posn
; extract fired,
; return a posn that includes
; state of tank
(check-expect (get_tank fired_t) (make-posn 200 1))
(define (get_tank g)
 (make-posn
  (TANK-x (fired-TANK g))
  (TANK-dx (fired-TANK g))
  ))
; fired -> Number
; get the x coord of TANK
(check-expect (get_tank_x fired_t) 200)
(define (get_tank_x g)
  (posn-x (get_tank g))
  )
; fired -> Number
; get the speed of TANK
(check-expect (get_tank_dx fired_t) 1)
(define (get_tank_dx g)
  (posn-y (get_tank g))
  )
; SIG -> TANK
; get TANK from SIG
(check-expect (sig_fired_get_tank t) (make-TANK 200 1))
(define (sig_fired_get_tank sig)
  (fired-TANK (SIG-fired sig)))
; aim -> posn
; extract from aim,
; return a posn that includes
; coordinate of the UFO
(check-expect (aim_get_ufo aim_t) (make-posn 20 30))
(define (aim_get_ufo g)
 (make-posn
  (UFO-x (aim-UFO g))
  (UFO-y (aim-UFO g))
  ))
; aim -> Number
; get the x coord of UFO
(check-expect (aim_get_ufo_x aim_t) 20)
(define (aim_get_ufo_x g)
  (posn-x (aim_get_ufo g))
  )
; aim -> Number
; get the y coord of UFO
(check-expect (aim_get_ufo_y aim_t) 30)
(define (aim_get_ufo_y g)
  (posn-y (aim_get_ufo g))
  )
; SIG -> UFO
; get UFO from SIG
(check-expect (sig_aim_get_ufo t) (make-UFO 20 30))
(define (sig_aim_get_ufo sig)
  (aim-UFO (SIG-aim sig)))
; aim -> posn
; extract fired,
; return a posn that includes
; state of tank
(check-expect (aim_get_tank aim_t) (make-posn 200 1))
(define (aim_get_tank g)
 (make-posn
  (TANK-x (aim-TANK g))
  (TANK-dx (aim-TANK g))
  ))
; aim -> Number
; get the x coord of TANK
(check-expect (aim_get_tank_x aim_t) 200)
(define (aim_get_tank_x g)
  (posn-x (aim_get_tank g))
  )
; aim -> Number
; get the speed of TANK
(check-expect (aim_get_tank_dx aim_t) 1)
(define (aim_get_tank_dx g)
  (posn-y (aim_get_tank g))
  )
; SIG -> TANK
; get TANK from SIG
(check-expect (sig_aim_get_tank t) (make-TANK 200 1))
(define (sig_aim_get_tank sig)
  (aim-TANK (SIG-aim sig)))
; game_state -> Number
; calculate the distance between missle and ufo
; Sqrt(delta_x^2 + delta_y*2)
(check-within (dist fired_t) (sqrt 800) 0.1)
(define (dist g)
  (sqrt
   (+ (expt
       (- (get_missle_x g) (get_ufo_x g))
       2)
      (expt
       (- (get_missle_y g) (get_ufo_y g))
       2))
   ))
; SIG -> Boolean
; determine if the game is in aim state
; if the coordinates of the missle are both zero
; the missle is not fired
(check-expect (aimed? T) #true)
(check-expect (aimed? t) #false)  
(define (aimed? sig)
 (and 
  (= (get_missle_x (SIG-fired sig)) 0)
  ( = (get_missle_y (SIG-fired sig)) 0)
 ))
; SIG -> Boolean
; determine if the game is in fired state
(check-expect (fire? T) #false)
(check-expect (fire? t) #true)    
(define (fire? sig)
  (not (and 
  (= (get_missle_x (SIG-fired sig)) 0)
  ( = (get_missle_y (SIG-fired sig)) 0)
 )))
; SIG -> Image 
; adds tank to the background
(check-expect
 (tank-render t)
 (place-image
  tank
  200 (- game_height 50)
  background
  )
 )
(define (tank-render sig)
  (place-image
   tank
   (get_tank_x (SIG-fired sig)) (- game_height 50)
   background
   ) 
 )
; SIG -> Image 
; adds UFO to background with tank
; this is the second to last image of fired state
; this is also the last state of aim state
(check-expect
 (tank-ufo-render t)
 (place-image
   ufo
   20 30
   (tank-render t)))
(define (tank-ufo-render sig)
  (place-image
   ufo
   (get_ufo_x (SIG-fired sig)) (get_ufo_y (SIG-fired sig))
   (tank-render sig)
   )
  )

; render function
; SIG -> Image
; render the aim state of the image
(check-expect (aim-render t) (tank-ufo-render t))
(define (aim-render sig)
  (tank-ufo-render sig)
  )
; SIG -> Image
; render the fired state of the image
(check-expect
 (fire-render t)
 (place-image
  missle
  40 10
  (tank-ufo-render t)))
(define (fire-render sig)
  (place-image
   (if (= (get_missle_y (SIG-fired sig)) 0) (empty-scene 0 0) missle)
   (get_missle_x (SIG-fired sig)) (get_missle_y (SIG-fired sig))
   (tank-ufo-render sig)
   )
  )
; SIG -> Image
; render an Image base on SIG,
; might be aim or fired
(check-expect (si_render T) (aim-render T))
(check-expect (si_render t) (fire-render t))
(define (si_render sig)
  (cond
    [(aimed? sig) (aim-render sig)]
    [(fire? sig) (fire-render sig)]
    )
  )
; tick control functions
; Number -> Number
; randomly generate ufo movement
; a number in the interval [1,n) is generated
; that number is then multiple by either 1 or -1,
; depends on what number the second random statement generate
; (0 is -1, 1 is 1)
(check-random (random_number 10)
              (* (+ (random 10) 1)
     (if (= (random 2) 0) -1 1)
     ))
(define (random_number n)
  (* (+ (random n) 1)
     (if (= (random 2) 0) -1 1)
     )
  )
; SIG -> Number
; ufo x coordinate movement per tick
(check-expect (ufo_tock_x t 5) 25)
(check-expect (ufo_tock_x t 1000) 20)
(define (ufo_tock_x sig rand)
(if
   (<= 20 (+ (get_ufo_x (SIG-fired sig)) rand) (- game_width 20))
   (+ (get_ufo_x (SIG-fired sig)) rand)
   (get_ufo_x (SIG-fired sig))
   )
  )
; SIG -> Number
; ufo y coordinate movement per tick
(check-expect (ufo_tock_y t) 31)
(define (ufo_tock_y sig)
  (+ (get_ufo_y (SIG-fired sig)) 1)
  )
; SIG Number -> UFO
; modify the ufo coord according to tick
(check-expect (ufo_coord_chg t 10) (make-UFO 30 31))
(define (ufo_coord_chg sig rand)
  (make-UFO (ufo_tock_x sig rand) (ufo_tock_y sig)))
; SIG Number -> SIG
; store the changed ufo coord as SIG,
; the coord change according to rand
(check-expect (ufo_tock_cal t 0)
              (make-SIG
  (make-aim
      (sig_aim_get_tank t)
      (make-UFO 20 31))
  (make-fired
      (sig_fired_get_tank t)
      (make-UFO 20 31)
      (sig_fired_get_missle t))
 ))
(define (ufo_tock_cal sig rand)
(make-SIG
  (make-aim
      (sig_aim_get_tank sig)
      (ufo_coord_chg sig rand))
  (make-fired
      (sig_fired_get_tank sig)
      (ufo_coord_chg sig rand)
      (sig_fired_get_missle sig))
 ))
; SIG -> MISSLE
; if the missle is launched,
; the missle move up double the speed of UFO
(define (missle_tock_e sig)
   (cond
     [(< (get_missle_y (SIG-fired sig)) 0) (make-MISSLE 0 0)]
     [(>(get_missle_y (SIG-fired sig)) 0) (make-MISSLE (get_missle_x (SIG-fired sig)) (- (get_missle_y (SIG-fired sig)) (* ufo_speed 2)) )]
     [else (fired-MISSLE (SIG-fired sig))]
     )
  )
; SIG -> SIG
; fired state change per tick
(define (missle_tock sig)
  (make-SIG
      (make-aim
        (fired-TANK (SIG-fired sig))
        (fired-UFO (SIG-fired sig))
      )
      (make-fired
        (fired-TANK (SIG-fired sig))
        (fired-UFO (SIG-fired sig))
        (missle_tock_e sig)
      )))
; SIG -> SIG
; store the changed ufo coord as SIG
; change the missle and ufo base on tick
(check-random (fire_tock t)
              (ufo_tock_cal (missle_tock t) (random_number 10)))
(define (fire_tock sig)
  (ufo_tock_cal (missle_tock sig) (random_number 10)))
; SIG -> SIG
; aim state change per tick
(check-random (aim_tock t)
              (ufo_tock_cal (missle_tock t) (random_number 10)))
(define (aim_tock sig) (ufo_tock_cal (missle_tock sig) (random_number 10)))
; SIG -> SIG
; modify the WorldState base
; per tick
(define (si_tock sig)
  (cond
    [(fire? sig) (fire_tock sig)]
    [(aimed? sig) (aim_tock sig)]
    ))
; stopping function
; SIG -> boolean
; detect whether it's gameover
(define (lost? sig)
  (>= (get_ufo_y (SIG-fired sig)) 240)
  )
; SIG -> boolean
; detect whether the player won
(define (win? sig)
  (and (< (dist (SIG-fired sig))  20) (not (= (get_missle_y (SIG-fired sig)) 0)))
  )
; SIG -> boolean Image
; stop-when function
; if both win? and lost?
; functions return #true,
; the player wins
; either win or lose, the function returns a last world State
;(check-expect (STOP t) #false)
(define (STOP sig)
  (cond
    [(win? sig) #true]
    [(lost? sig) #true]
    [else #false]
    ))
; SIG -> Image
; render the last world-image, overlayed
; with either game-over or you win!
(define (last_image sig)
(overlay
 (if (win? sig) (text "YOU WIN!" 50 "blue") (text "GAME OVER!" 50 "blue"))
 (si_render sig)
  ))
; keyevent functions
; SIG -> SIG
; missle is launched
; the missle assume the x coordinate
; of the tank
(define (space_launch sig)
    (make-SIG
     (SIG-aim sig)
     (make-fired
      (fired-TANK (SIG-fired sig))
      (fired-UFO (SIG-fired sig))
      (make-MISSLE (get_tank_x (SIG-fired sig)) (- game_height 50)))
    )
  )
; keyevent functions
; SIG KeyEvent -> SIG
; the tank is moved
; "-1" is to the left
; "1" is to the right
(define (tank_mov sig direction)
   (make-SIG
      (make-aim
       (make-TANK (+ (aim_get_tank_x (SIG-aim sig)) direction) (aim_get_tank_dx (SIG-aim sig)))
       (sig_aim_get_ufo sig)
       )
    (make-fired
       (make-TANK (+ (aim_get_tank_x (SIG-aim sig)) direction) (aim_get_tank_dx (SIG-aim sig)))
       (sig_fired_get_ufo sig)
       (sig_fired_get_missle sig)
     )
    )
  )
; SIG KeyEvent -> SIG
(define (KEY sig keystroke)
  (cond
    [(and (string=? keystroke " ") (= (get_missle_y (SIG-fired sig)) 0)) (space_launch sig)]
    [(string=? keystroke "left") (tank_mov sig (* (get_tank_dx (SIG-fired sig)) -1))]
    [(string=? keystroke "right") (tank_mov sig (get_tank_dx (SIG-fired sig)))]
    [else sig]
    )
  )
; example starter
(define fired_E
(make-fired
   (make-TANK 200 5)
   (make-UFO 200 30)
   (make-MISSLE 0 0))
 )
; example aim definition
(define aim_E
(make-aim
   (make-TANK 200 5)
   (make-UFO 20 30)
 ))
; example SIG definition
(define E (make-SIG aim_E fired_E))
(define (main k)
(big-bang E
  [to-draw si_render]
  [on-tick si_tock]
  [on-key KEY]
  [stop-when STOP last_image]
   )
  )