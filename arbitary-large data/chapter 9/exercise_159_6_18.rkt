;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise_159_6_18) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)
(define-struct pair [balloon# lob ticks])
; A Pair is a structure (make-pair N List-of-posns ticks)
; A List-of-posns is one of: 
; – '()
; – (cons Posn List-of-posns)
; interpretation (make-pair n lob ticks) means n balloons 
; must yet be thrown and added to lob, ticks represent how many ticks
; have passed
; image constant definition
(define circ (circle 5 "solid" "yellow"))
(define SQUARE (rectangle 10 10 "outline" "black"))
; Natural Number Image -> Image
; consumes a Natural number n and an image,
; produces n copies of the Image horrizontally
(check-expect (row 5 circ) (beside circ circ circ circ circ))
(define (row n img)
  (cond
    [(= n 1) img]
    [(number? n) (beside (row (sub1 n) img) img)]
    ))
; Natural Number Image -> Image
; consumes a Natural number n and an image,
; produces n copies of the Image vertically
(check-expect (col 5 circ) (above circ circ circ circ circ))
(define (col n img)
  (cond
    [(= n 1) img]
    [(number? n) (above (col (sub1 n) img) img)]
    ))
; image definition
(define background
(overlay (col 18 (row 8 SQUARE)) (empty-scene 80 180))
  )
(define red_dot (circle 4 "solid" "red"))
; List-of-posn is one of:
; - (cons posn '())
; - (cons posn List-of-posn)
(define red-dots (cons (make-posn 10 50) (cons (make-posn 20 50) (cons (make-posn 30 50) '()))))
; axuiliary function
; Pair -> pair
; increase tick by one
(check-expect (p-tick (make-pair 2 red-dots 1)) (make-pair 2 red-dots 2))
(define (p-tick p)
  (make-pair (pair-balloon# p) (pair-lob p) (add1 (pair-ticks p))))
; Pair -> Pair
; throw a balloon onto the scene per second
(define (tock p)
  (cond
    [(not (zero? (modulo (pair-ticks p) 28))) (p-tick p)]
    [(not (zero? (pair-balloon# p)))
     (make-pair
      (sub1 (pair-balloon# p))
      (cons  (make-posn (random 80) (random 180)) (pair-lob p))
      (+ (pair-ticks p) 1))
     ]
    [else (p-tick p)]
    ))
; List-of-posn -> Image
; place red dots on the lecture hall with coordinates
; specified by List-of-posn
(check-expect (add-balloon red-dots) (place-images (make-list 3 red_dot) red-dots background))
(define (add-balloon lpos)
  (cond
    [(empty? lpos)
        background]
    [(cons? lpos)
     (place-image/align
         red_dot
         (posn-x (first lpos)) (posn-y (first lpos))
         "center" "center"
         (add-balloon (rest lpos)))
     ]
    ))
; Pair -> Image
; render the image with existing coordinates
(check-expect (render (make-pair 1 red-dots 2))
              (place-images (make-list 3 red_dot) red-dots background))
(define (render p)
  (add-balloon (pair-lob p)))
; main function
(define (riot p0)
  (big-bang p0
    [to-draw render]
    [on-tick tock]
    ))
