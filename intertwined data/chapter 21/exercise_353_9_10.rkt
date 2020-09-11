;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_353_9_10) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct add [left right])
(define-struct mul [left right])
; A BSL-var-expr is one of: 
; – Number
; – Symbol 
; – (make-add BSL-var-expr BSL-var-expr)
; – (make-mul BSL-var-expr BSL-var-expr)

; a BSL-expr is one of:
; Number
; – (make-add BSL-expr BSL-expr)
; – (make-mul BSL-expr BSL-expr)

; BSL-var-expr -> Boolean
; determine if the given BSL-var-expr
; is also a BSL-expr
(check-expect (numeric? '(make-add (k (make-mul (make-add k 5) k)))) #f)
(check-expect (numeric? '(make-add (30 (make-mul (make-add 10 5) 40)))) #t)
(define (numeric? bslve)
  (cond
    [(number? bslve) #t]
    [(symbol? bslve) #f]
    [(cons? bslve)
     (andmap numeric? (rest bslve))]))