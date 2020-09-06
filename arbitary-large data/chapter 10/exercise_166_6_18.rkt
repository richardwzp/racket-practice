;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise_166_6_18) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct work [employee rate hours])
; A (piece of) Work is a structure: 
;   (make-work String Number Number)
; interpretation (make-work n r h) combines the name 
; with the pay rate r and the number of hours h

; Low (short for list of works) is one of: 
; – '()
; – (cons Work Low)
; interpretation an instance of Low represents the 
; hours worked for a number of employees

(define-struct check [employee amount])
; check is a structure:
;   (make-check String Number)
; interpretation combiens the name of the employee with
; the amount they make

; Paycheck is one of:
; - '()
; - (cons check Low)
; interpretation an instance of payceck represents the amount of paycheck for
; name of employees

; Low -> List-of-numbers
; computes the weekly wages for all weekly work records 
(check-expect
  (wage*.v4 (cons (make-work "Robby" 11.95 39) '()))
  (cons (make-check "Robby" (* 11.95 39)) '())) 
(define (wage*.v4 an-low)
  (cond
    [(empty? an-low) '()]
    [(cons? an-low) (cons (wage.v4 (first an-low))
                          (wage*.v4 (rest an-low)))]))
 
; Work -> Number
; computes the wage for the given work record w
(define (wage.v4 w)
  (make-check (work-employee w) (* (work-rate w) (work-hours w))))

