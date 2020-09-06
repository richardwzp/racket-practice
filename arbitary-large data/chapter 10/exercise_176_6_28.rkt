;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise_176_6_28) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define row1 (cons 11 (cons 12 '())))
(define row2 (cons 21 (cons 22 '())))
(define mat1 (cons row1 (cons row2 '())))

 
(define wor1 (cons 11 (cons 21 '())))
(define wor2 (cons 12 (cons 22 '())))
(define tam1 (cons wor1 (cons wor2 '())))
; helper function
; Matrix -> Row
; extract the first column, and change it into a row
(check-expect (first* mat1) (cons 11 (cons 21 '())))
(define (first* lln)
  (cond
    [(empty? (rest lln)) (cons (first (first lln)) '())]
    [else
     (cons (first (first lln)) (first* (rest lln)))
     ]))
; Matrix -> Matrix
; deleted the first item of each row
(check-expect (rest* mat1) (cons (cons 12 '()) (cons (cons 22 '()) '())))
(define (rest* lln)
  (cond
    [(empty? (rest lln)) (cons (rest (first lln)) '())]
    [else
     (cons (rest (first lln)) (rest* (rest lln)))
     ]))

; Matrix -> Matrix
; transposes the given matrix along the diagonal 
(check-expect (transpose mat1) tam1)
(define (transpose lln)
  (cond
    [(empty? (first lln)) '()]
    [else (cons (first* lln) (transpose (rest* lln)))]))
