;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise_145_6_15) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; NElist-of-temperature is one of
; - (cons cTemp '())
; - (cons cTemp NElist-of-temperature)

; NElist -> boolean
; determine if NElist is in descending order
(check-expect (sorted>? (cons 7 (cons 6 (cons 5 (cons 4 (cons 1 '())))))) #true)
(check-expect (sorted>? (cons 7 (cons 6 (cons 5 (cons 7 (cons 1 '())))))) #false)
(check-expect (sorted>? (cons 7 (cons 6 (cons 5 (cons 4 (cons 5 '())))))) #false)
(define (sorted>? NElist)
  (cond
    [(empty? (rest NElist)) #true]
    [else
     (if
      (> (first NElist) (first (rest NElist)))
      (sorted>? (rest NElist))
      #false)]
    ))