;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_352_9_10) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct add [left right])
(define-struct mul [left right])
; A BSL-var-expr is one of: 
; – Number
; – Symbol 
; – (make-add BSL-var-expr BSL-var-expr)
; – (make-mul BSL-var-expr BSL-var-expr)


; BSL-var-expr Symbol Number ->  BSL-var-expr
(check-expect (subst '(make-add (k (make-mul (make-add k 5) k))) 'k 200) '(make-add (200 (make-mul (make-add 200 5) 200))))
(define (subst ex x v)
  (cond
    [(symbol? ex) (if (symbol=? ex x) v ex)]
    [(number? ex) ex]
    [(cons? ex)
         (map
          (lambda (item) (subst item x v))
           ex)]))