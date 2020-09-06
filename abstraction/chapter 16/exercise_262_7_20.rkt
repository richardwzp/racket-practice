;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise_262_7_20) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))


; Number -> list-of-list
; create diagnal square
(check-expect (identityM 1) (list (list 1)))
(check-expect (identityM 3) (list (list 1 0 0) (list 0 1 0) (list 0 0 1))
)
(define (identityM num)
  (local 
    (
     ; build a list that's member of diagnal square
     (define (build-diagnal-list-with-1 n position)
       (local ((define (is1-or-0? x) (if (= x position) 1 0)))
       (build-list n is1-or-0?)))
     ; build the diagnal square
     (define (build-diagnal-list n)
       (cond
      [(= n 0) '()]
      [else
       (cons (build-diagnal-list-with-1 num (- num n)) (build-diagnal-list (- n 1)))]))
     )
    ; main expression
    (build-diagnal-list num)
    ))
