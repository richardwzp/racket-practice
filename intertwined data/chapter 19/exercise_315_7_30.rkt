;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_315_7_30) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; A [list-of FT] is one of:
; - '()
; - (cons FT [list-of FT])

(define-struct no-parent [])
(define-struct child [father mother name date eyes])
; An FT (short for family tree) is one of: 
; – (make-no-parent)
; – (make-child FT FT String N String)

(define NP (make-no-parent))
; An FT is one of: 
; – NP
; – (make-child FT FT String N String)

; FT -> Boolean
; does an-ftree contain a child
; structure with "blue" in the eyes field
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

 
(check-expect (blue-eyed-child? Carl) #false)
(check-expect (blue-eyed-child? Gustav) #true)

(define (blue-eyed-child? an-ftree)
  (cond
    [(no-parent? an-ftree) #false]
    [else (or (string=? (child-eyes an-ftree) "blue")
              (blue-eyed-child? (child-father an-ftree))
              (blue-eyed-child? (child-mother an-ftree)))]))

(define ff1 (list Carl Bettina))
(define ff2 (list Fred Eva))
(define ff3 (list Fred Eva Carl))

; FF -> Boolean
; does the forest contain any child with "blue" eyes
(check-expect (blue-eyed-child-in-forest? ff1) #false)
(check-expect (blue-eyed-child-in-forest? ff2) #true)
(check-expect (blue-eyed-child-in-forest? ff3) #true)
(define (blue-eyed-child-in-forest? a-forest)
  (ormap blue-eyed-child? a-forest))

; FT -> Number
; count the amount of people in the family tree
(check-expect (count Gustav) 5)
(define (count ft)
  (cond
   [(no-parent? ft) 0]
   [else (+ 1 (count (child-father ft)) (count (child-mother ft)))]))

; FT Number -> Number
     ; sum the age up
(check-expect (sum-age Carl 2000) 74)
     (define (sum-age ft yr)
       (cond
         [(no-parent? ft) 0]
         [else (+ (- yr (child-date ft)) (sum-age (child-father ft) yr) (sum-age (child-mother ft) yr))]))

; FF -> Number
; calculate average of all family tree
(check-expect (average-ff-age ff3 2000) 58.2)
(define (average-ff-age loff yr)
  (/
   (foldr (lambda (x base) (+ base (sum-age x yr))) 0 loff)
   (foldr (lambda (x base) (+ base (count x))) 0 loff)))

