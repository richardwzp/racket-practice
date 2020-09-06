;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise_187_7_1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct gp [name score])
; A GamePlayer is a structure: 
;    (make-gp String Number)
; interpretation (make-gp p s) represents player p who 
; scored a maximum of s points

; example for testing 
(define ex (list (make-gp "ty" 100) (make-gp "cab" 120) (make-gp "jer" 130)))
(define ex2 (list (make-gp "jer" 130) (make-gp "cab" 120) (make-gp "ty" 100)))

; list-of-gp -> list-of-gp
; produces a sorted version of gp
(check-satisfied (sort> ex) sort>?)
(define (sort> lgp)
  (cond
    [(empty? lgp) '()]
    [(cons? lgp) (insert (first lgp) (sort> (rest lgp)))]))
 
; gp list-of-gp -> list-of-gp
; inserts n into the sorted list of numbers l
(check-satisfied (insert (make-gp "jon" 110) ex2) sort>?)
(define (insert gpp lgp)
  (cond
    [(empty? lgp) (cons gpp '())]
    [else (if (>= (gp-score gpp) (gp-score (first lgp)))
              (cons gpp lgp)
              (cons (first lgp) (insert gpp (rest lgp))))]))
; List-of-gp -> Boolean
; check if the list is in desending order
(check-expect (sort>? ex) #f)
(check-expect (sort>? ex2) #t)
(define (sort>? lgp)
  (cond
    [(empty? (rest lgp)) #t]
    [(cons? (rest lgp)) (and (>= (gp-score (first lgp)) (gp-score (first (rest lgp)))) (sort>? (rest lgp)))]
    ))
