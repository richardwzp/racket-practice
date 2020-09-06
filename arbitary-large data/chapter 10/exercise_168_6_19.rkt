;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise_168_6_19) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; List-of-posn -> List-of-posn
; increase all y value of posn in the list
; by 1
(check-expect
 (translate (cons (make-posn 3 4) (cons (make-posn 6 7) '())))
 (cons (make-posn 3 5) (cons (make-posn 6 8) '())))
(define (translate lpos)
  (cond
    [(empty? lpos) '()]
    [(cons? lpos)
     (cons (translate-posn (first lpos)) (translate (rest lpos)))]
    ))
; posn -> posn
; increase the y value by 1
(check-expect (translate-posn (make-posn 2 3)) (make-posn 2 4))
(define (translate-posn pos)
  (make-posn (posn-x pos) (+ (posn-y pos) 1)))