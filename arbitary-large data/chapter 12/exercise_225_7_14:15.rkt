;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise_225_7_14:15) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

; constant

; graphic constant
(define PLANE (ellipse 20 10 "solid" "red"))
(define FIRE (overlay (ellipse 6 10 "solid" "red") (ellipse 10 15 "solid" "orange")))
(define WATER (ellipse 5 10 "solid" "blue"))
(define CANVAS (empty-scene 100 100))


; data definition

; a plane is a structure of:
; (make-plane Number Number)
; interpretation the physical location of the plane
(define-struct plane [x y])

; a fire is one of:
; - '()
; - (cons Number fire)
; interpretation fire represents a list of x values of all fire

; a water-drop is a structure of:
; (make-water-drop Number Number)
; interpretation the physical location of the water drops
(define-struct water-drop [x y])

; a water is one of:
; - '()
; - (cons water-drop water)
; interpretaion how much water is on screen

; a game-state is a structure of:
; (make-game-state plane fire water)
; interpretation the overall game state
(define-struct game-state [plane fire water])



; helper
; list -> element
; retrieve last element of the list
(check-expect (last (list 4 5 6 7)) 7)
(check-error (last '()) "last: expect list, recieved empty list")
(define (last li)
  (cond
    [(empty? li) (error "last: expect list, recieved empty list")]
    [(empty? (rest li)) (first li)]
    [else (last (rest li))]))

; plane Image -> Image
; render the plane onto the accepted background
(check-expect (plane-render (make-plane 20 20) CANVAS)
              (place-image PLANE 20 20 CANVAS))
(define (plane-render pl img)
  (place-image
   PLANE
   (plane-x pl) (plane-y pl)
   img))


; plane keystroke -> plane
; control the plane movement with keyEvent
(check-expect (plane-key (make-plane 40 20) "right") (make-plane 45 20))
(check-expect (plane-key (make-plane 40 20) "left") (make-plane 35 20))
(check-expect (plane-key (make-plane 40 20) "shift") (make-plane 40 20))
(define (plane-key pl keystroke)
  (cond
    [(and (string=? keystroke "right") (< (plane-x pl) 90)) (make-plane (+ (plane-x pl) 5) (plane-y pl))]
    [(and (string=? keystroke "left") (> (plane-x pl) 10)) (make-plane (- (plane-x pl) 5) (plane-y pl))]
    [else pl]
    ))

; Number fire -> Boolean
; if number is +-5 of any elements of fire,
; return True
; else return False
(check-expect (within-10? 10 (list 15 30 55)) #t)
(check-expect (within-10? 10 (list 30 42 55)) #f)
(define (within-10? num fi)
  (cond
    [(empty? fi) #f]
    [else
     (if (<= (- (first fi) 10) num (+ (first fi) 10)) #t (within-10? num (rest fi)))]))

; Number fire -> fire
; check if the generated number is a member of fire
; if it is, generate again
(check-satisfied (check-generate-fire 20 (list 20 10 5)) cons?)
(define (check-generate-fire num fi)
  (if (or (member? num fi) (within-10? num fi))
      (generate-fire fi)
      (cons num fi)))

; fire -> fire
; generate a new fire
(check-satisfied (generate-fire (list 5 20)) cons?)
(define (generate-fire fi)
  (check-generate-fire (+ (random 80) 10) fi))

; fire -> fire
; randomly generate a new fire,
; by chance
(check-satisfied (fire-tock (list 5 20)) cons?)
(define (fire-tock fi)
  (if (and (= 0 (remainder (random 100) 99)) (<= (length fi) 5))
      (generate-fire fi)
      fi))

; fire Image -> Image
; render the fire ontothe given image
(check-expect (fire-render (list 20 30) CANVAS)
              (place-image FIRE 20 90
                           (place-image FIRE 30 90 CANVAS)))
(define (fire-render fi img)
  (cond
    [(empty? fi) img]
    [else
     (place-image
      FIRE
      (first fi) 90
      (fire-render (rest fi) img))]))


; water Image -> Image
; render water onto background
(check-expect (water-render (list (make-water-drop 20 20)) CANVAS) (place-image WATER 20 20 CANVAS))
(define (water-render wa img)
  (cond
    [(empty? wa) img]
    [else
     (place-image WATER
                  (water-drop-x (first wa)) (water-drop-y (first wa))
                  (water-render (rest wa) img))]))

; water -> water
; water move down by increment, per tick
(check-expect (water-tock (list (make-water-drop 20 30))) (list (make-water-drop 20 33)))
(check-expect (water-tock (list (make-water-drop 20 33) (make-water-drop 20 36) (make-water-drop 20 99))) (list (make-water-drop 20 36) (make-water-drop 20 39)))
(check-expect (water-tock (list (make-water-drop 20 103) (make-water-drop 20 36) (make-water-drop 20 99))) (list (make-water-drop 20 39)))
(define (water-tock wa)
  (cond
    [(empty? wa) wa]
    [(empty? (rest wa)) (if (>= (water-drop-y (first wa)) 90) '() (cons (make-water-drop (water-drop-x (first wa)) (+ (water-drop-y (first wa)) 3)) '()))]
    [else
     (if (>= (water-drop-y (first wa)) 90) (water-tock (rest wa))
     (cons (make-water-drop (water-drop-x (first wa)) (+ (water-drop-y (first wa)) 3)) (water-tock (rest wa))))
     ]))


; water plane -> water
; space bar is pressed, an additional one is appended
(check-expect (water-fired (list (make-water-drop 20 30) (make-water-drop 20 33)) (make-plane 20 20)) (list (make-water-drop 20 20) (make-water-drop 20 30) (make-water-drop 20 33)))
(define (water-fired wa pl)
  (cons (make-water-drop (plane-x pl) (plane-y pl)) wa))

; water  plane keystroke -> water
; water key handler
; note: needs plane to be passed as var too
(check-expect (water-key (list (make-water-drop 20 30) (make-water-drop 20 33)) (make-plane 20 20) " ") (list (make-water-drop 20 20) (make-water-drop 20 30) (make-water-drop 20 33)))
(define (water-key wa pl keystroke)
  (cond
    [(string=? keystroke " ") (water-fired wa pl)]
    [else wa]
    ))

; distance-between-point
; Posn Posn -> number
; get distance between two points
(check-expect (distance-between-point (make-posn 0 3) (make-posn 4 0)) 5)
(define (distance-between-point p1 p2)
  (sqrt
   (+ (expt (- (posn-y p2) (posn-y p1)) 2)
   (expt (- (posn-x p2) (posn-x p1)) 2))))

; wad Number -> Boolean
; Number here is a member of fire,
; determine if the two points are close enough
(check-expect (extinguished? (make-water-drop 20 90) 15) #t)
(check-expect (extinguished? (make-water-drop 20 90) 50) #f)
(define (extinguished? wad fi)
  (<=
   (floor (distance-between-point (make-posn (water-drop-x wad) (water-drop-y wad)) (make-posn fi 90)))
   10))

; water-drop fire -> fire
; check if any fire is distinguished by the fire
(check-expect (extinguish-fire (make-water-drop 20 90) (list 50 70 80 5 19)) (list 50 70 80 5))
(check-expect (extinguish-fire (make-water-drop 20 90) (list 50)) (list 50))
(define (extinguish-fire wad fi)
  (cond
    [(empty? fi) fi]
    [else
     (if (extinguished? wad (first fi))
         (extinguish-fire wad (rest fi))
         (cons (first fi) (extinguish-fire wad (rest fi)))
         )]))

; game-state -> Image
; render game
(check-expect (fire-game-render (make-game-state (make-plane 20 20) (list) (list))) (place-image PLANE 20 20 CANVAS))
(define (fire-game-render gs)
  (plane-render (game-state-plane gs)
                (fire-render (game-state-fire gs)
                             (water-render (game-state-water gs) CANVAS))))

; game-state -> game-state
; tick handler
(check-satisfied (fire-game-tock (make-game-state (make-plane 20 20) (list) (list))) game-state?)
(define (fire-game-tock gs)
  (make-game-state
   (game-state-plane gs)
   (if (empty? (water-tock (game-state-water gs)))
       (fire-tock (game-state-fire gs))
       (extinguish-fire (last (water-tock (game-state-water gs))) (fire-tock (game-state-fire gs))))
   (water-tock (game-state-water gs))))

; game-state key -> game-state
(check-expect (fire-game-key (make-game-state (make-plane 20 20) (list) (list)) "shift") (make-game-state (make-plane 20 20) (list) (list)))
(define (fire-game-key gs keystroke)
  (make-game-state
   (plane-key (game-state-plane gs) keystroke)
   (game-state-fire gs)
   (water-key (game-state-water gs) (game-state-plane gs) keystroke)))


; game-state -> Image
; big bang function
(check-satisfied (fire-game-main (make-game-state (make-plane 30 10) (list) (list (make-water-drop 20 30)))) game-state?)
(define (fire-game-main gs)
  (big-bang gs
      [to-draw fire-game-render]
      [on-tick fire-game-tock]
      [on-key fire-game-key]
      ))
