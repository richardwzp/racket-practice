;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise_169_6_19) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define example
  (cons (make-posn 30 205)
        (cons (make-posn 100 30)
              (cons (make-posn 101 50)
                    (cons (make-posn 105 204) '())))))
; List-of-posn -> List-of-posn
; result contains all posn whose x coordinates
; are between 0 and 100,
; and whose y coordinates are between 0 and 200
(check-expect (legal example)
              (cons (make-posn 100 30) '()))
(define (legal lpos)
  (cond
    [(empty? lpos) '()]
    [(cons? lpos)
     (if (legal-posn (first lpos))
         (cons (first lpos)(legal (rest lpos)))
         (legal (rest lpos)))]
    ))
; posn -> posn
; if posn whose x coordinates
; are between 0 and 100,
; and whose y coordinates are between 0 and 200
(check-expect (legal-posn (make-posn 101 30)) #f)
(check-expect (legal-posn (make-posn 11 201)) #f)
(check-expect (legal-posn (make-posn 101 201)) #f)
(check-expect (legal-posn (make-posn 99 30)) #t)
(define (legal-posn pos)
  (if
    (<= 0 (posn-x pos) 100)
    (if (<= 0 (posn-y pos) 200) #t #f)
    #f
    ))
