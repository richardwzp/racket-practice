;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise_188_7_1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct email [from date message])
; An Email Message is a structure: 
;   (make-email String Number String)
; interpretation (make-email f d m) represents text m 
; sent by f, d seconds after the beginning of time 

; example for testing 
(define ex (list (make-email "jer" 130 "sup") (make-email "cab" 120 "hello") (make-email "ty" 100 "dop")))
(define ex2 (list (make-email "ty" 100 "dop") (make-email "cab" 120 "hello") (make-email "jer" 130 "sup")))

; list-of-email -> list-of-email
; produces a sorted version of email
(check-satisfied (sort< ex) sort<?)
(define (sort< lem)
  (cond
    [(empty? lem) '()]
    [(cons? lem) (insert (first lem) (sort< (rest lem)))]))
 
; gp list-of-email -> list-of-email
; inserts email into the sorted list of emails
(check-satisfied (insert (make-email "jon" 110 "yoyo") ex2) sort<?)
(define (insert em lem)
  (cond
    [(empty? lem) (cons em '())]
    [else (if (<= (email-date em) (email-date (first lem)))
              (cons em lem)
              (cons (first lem) (insert em (rest lem))))]))
; List-of-gp -> Boolean
; check if the list is in desending order
(check-expect (sort<? ex) #f)
(check-expect (sort<? ex2) #t)
(define (sort<? lem)
  (cond
    [(empty? (rest lem)) #t]
    [(cons? (rest lem)) (and (<= (email-date (first lem)) (email-date (first (rest lem)))) (sort<? (rest lem)))]
    ))

(define ex3 (list (make-email "ty" 100 "dop") (make-email "jer" 130 "sup") (make-email "cab" 120 "hello")))
(define ex4 (list (make-email "cab" 120 "hello") (make-email "jer" 130 "sup") (make-email "ty" 100 "dop")))
; list-of-email -> list-of-email
; produces a sorted version of email by name
(check-satisfied (sort<name ex3) sort<name?)
(define (sort<name lem)
  (cond
    [(empty? lem) '()]
    [(cons? lem) (insert-email (first lem) (sort<name (rest lem)))]))
; gp list-of-email -> list-of-email
; inserts email into the sorted list of emails by name
(check-satisfied (insert-email (make-email "jon" 110 "yoyo") ex4) sort<name?)
(define (insert-email em lem)
  (cond
    [(empty? lem) (cons em '())]
    [else (if (string<? (email-from em) (email-from (first lem)))
              (cons em lem)
              (cons (first lem) (insert-email em (rest lem))))]))
; List-of-gp -> Boolean
; check if the list is in desending order
(check-expect (sort<name? ex3) #f)
(check-expect (sort<name? ex4) #t)
(define (sort<name? lem)
  (cond
    [(empty? (rest lem)) #t]
    [(cons? (rest lem)) (and (string<? (email-from (first lem)) (email-from (first (rest lem)))) (sort<name? (rest lem)))]
    ))