;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_347_9_7) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 347


; data representation
(define-struct add [left right])
(define-struct mul [left right])

; BSL-expr -> Number
; evalute expression that are either add or multiply
(check-expect (eval-bool-expression (make-add 1 2)) 3)
(check-expect (eval-bool-expression (make-mul 5 2)) 10)
(check-expect (eval-bool-expression (make-add (make-mul 4 3) (make-add 1 (make-mul 3 2)))) 19)
(define (eval-bool-expression expr)
  (local
    (; expr/Number -> Number
    ; if input is atomic, return Number,
    ; else evalute it
    (define (eval ex-num)
      (if (number? ex-num) ex-num (eval-bool-expression ex-num))
      )
    )
    (cond
    [(add? expr) (+ (eval (add-left expr)) (eval (add-right expr)))]
    [(mul? expr) (* (eval (mul-left expr)) (eval (mul-right expr)))])))