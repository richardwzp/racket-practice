;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise_162_6_18) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define WAGE 14)
(define MESSAGE "check-wage*: reality check, wage hours cannot exceed 100")
; List-of-numbers -> List-of-numbers/error
; the output is one of:
; - error if one of the work hours exceed 100
; - List-of-numbers (price change)
(check-expect (check-wage* (cons 4 (cons 7 (cons 10 '()))))
              (cons (* 4 WAGE) (cons (* 7 WAGE) (cons (* 10 WAGE) '()))))
(check-error (check-wage* (cons 100 (cons 7 (cons 10 '())))) MESSAGE)
(define (check-wage* whrs)
  (cond
    [(check-wage whrs) (error MESSAGE)]
    [else (wage* whrs)]
    ))
; List-of_numbers -> boolean
; check if one of the wage exceed 100
(check-expect (check-wage (cons 4 (cons 7 (cons 10 '())))) #f)
(check-expect (check-wage (cons 100 (cons 7 (cons 10 '())))) #t)
(define (check-wage whrs)
  (cond
    [(empty? whrs) #f]
    [(cons? whrs)
     (if (>= (first whrs) 100) #t (check-wage (rest whrs)))]
    ))
; List-of-numbers -> List-of-numbers
; computes the weekly wages for all given weekly hours
(check-expect (wage* (cons 4 (cons 7 (cons 10 '()))))
              (cons (* 4 WAGE) (cons (* 7 WAGE) (cons (* 10 WAGE) '()))))
(define (wage* whrs)
  (cond
    [(empty? whrs) '()]
    [else (cons (wage (first whrs)) (wage* (rest whrs)))]))
 
; Number -> Number
; computes the wage for h hours of work
(check-expect (wage 10) (* WAGE 10))
(define (wage h)
  (* WAGE h))