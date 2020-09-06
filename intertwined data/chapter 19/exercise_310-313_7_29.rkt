;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_310-313_7_29) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct no-parent [])
(define-struct child [father mother name date eyes])
; An FT (short for family tree) is one of: 
; – (make-no-parent)
; – (make-child FT FT String N String)
(define NP (make-no-parent))
; An FT is one of: 
; – NP
; – (make-child FT FT String N String)

; Oldest Generation:
(define Carl (make-child NP NP "Carl" 1926 "green"))
(define Bettina (make-child NP NP "Bettina" 1926 "green"))
 
; Middle Generation:
(define Adam (make-child Carl Bettina "Adam" 1950 "hazel"))
(define Dave (make-child Carl Bettina "Dave" 1955 "black"))
(define Eva (make-child Carl Bettina "Eva" 1965 "blue"))
(define Fred (make-child NP NP "Fred" 1966 "pink"))
 
; Youngest Generation: 
(define Gustav (make-child Fred Eva "Gustav" 1988 "brown"))


; FT -> Number
; count the amount of people in the family tree
(check-expect (count Gustav) 5)
(define (count ft)
  (cond
   [(no-parent? ft) 0]
   [else (+ 1 (count (child-father ft)) (count (child-mother ft)))]))

; FT Number -> Number
; get the average age according to the given year
(check-within (average-age Gustav 2000) 45.8 0.1)
(define (average-age ft yr)
  (local
    (; FT Number -> Number
     ; sum the age up
     (define (sum-age ft yr)
       (cond
         [(no-parent? ft) 0]
         [else (+ (- yr (child-date ft)) (sum-age (child-father ft) yr) (sum-age (child-mother ft) yr))])))
    (/ (sum-age ft yr) (count ft))))

; FT -> [list-of eye-color]
; get all eyecolor present in the family tree
(check-satisfied (eye-colors Gustav) cons?)
(define (eye-colors ft)
  (cond
    [(no-parent? ft) '()]
    [else (append `(,(child-eyes ft)) (eye-colors (child-father ft)) (eye-colors (child-mother ft)))]))

; FT -> Boolean
; check if child has blue eye ancestor
(check-expect (blue-eyed-ancestor? Eva) #f)
(check-expect (blue-eyed-ancestor? Gustav) #t)
(define (blue-eyed-ancestor? an-ftree)
  (cond
    [(no-parent? an-ftree) #false]
    [(and (not (no-parent? (child-father an-ftree))) (string=? (child-eyes (child-father an-ftree)) "blue")) #t]
    [(and (not (no-parent? (child-mother an-ftree))) (string=? (child-eyes (child-mother an-ftree)) "blue")) #t]
    [else
     (or
       (blue-eyed-ancestor?
         (child-father an-ftree))
       (blue-eyed-ancestor?
         (child-mother an-ftree)))]))


