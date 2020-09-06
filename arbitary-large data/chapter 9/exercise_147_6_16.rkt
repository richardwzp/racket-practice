;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise_147_6_16) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; NElist-of-Boolean is one of:
; - (cons Boolean '())
; - (cons Boolean NElist-of-Boolean)

; NElist-of-Boolean -> Boolean
; determine if all elements of NElist are #true
(check-expect (all-true (cons #t (cons #t (cons #t (cons #t '()))))) #true)
(check-expect (all-true (cons #t (cons #t (cons #t (cons #f '()))))) #false)
(check-expect (all-true (cons #t (cons #f (cons #t (cons #t '()))))) #false)
(define (all-true NElist)
  (cond
    [(empty? (rest NElist)) (first NElist)]
    [else (if (first NElist) (all-true (rest NElist)) #false)]
    ))
; NElist-of-Boolean -> Boolean
; determine if any element of NElist is #true
(check-expect (one-true (cons #f (cons #f (cons #f (cons #t '()))))) #true)
(check-expect (one-true (cons #f (cons #f (cons #f (cons #f '()))))) #false)
(check-expect (one-true (cons #f (cons #t (cons #f (cons #f '()))))) #true)
(define (one-true NElist)
  (cond
    [(empty? (rest NElist)) (first NElist)]
    [else (if (first NElist) #true (one-true (rest NElist)))]
    ))
