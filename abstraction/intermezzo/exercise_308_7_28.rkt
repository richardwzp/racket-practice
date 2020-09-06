;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_308_7_28) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/abstraction)

(define-struct phone [area switch four])
; [list-of phone] -> [list-of phone]
; replace the area code 713 with 281
(define p1 (make-phone 713 329 4924))
(define p2 (make-phone 483 329 1948))
(define p3 (make-phone 182 394 3928))
(define mod-p1 (make-phone 281 329 4924))
(check-expect (replace `(,p1 ,p2 ,p3)) `(,mod-p1 ,p2 ,p3))
(define (replace lop)
  (for/list ([i lop])
    (match i
      [(phone 713 s t) (make-phone 281 s t)]
      [(phone f s t) (make-phone f s t)])))
