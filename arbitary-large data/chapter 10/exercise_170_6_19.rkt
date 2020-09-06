;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise_170_6_19) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct phone [area switch four])
; A Phone is a structure: 
;   (make-phone Three Three Four)
; A Three is a Number between 100 and 999. 
; A Four is a Number between 1000 and 9999.

; a List-of-phone is one of:
; - '()
; (cons Phone List-of-phone)
(define example (cons (make-phone 713 231 3428)
                      (cons (make-phone 382 482 1934)
                            (cons (make-phone 275 713 1849) '()))))

; List-of-Phone -> List-of-Phone
; change all occurance of area code 713 with 281
(check-expect (replace example)(cons (make-phone 281 231 3428)
                      (cons (make-phone 382 482 1934)
                            (cons (make-phone 275 713 1849) '()))))
(define (replace lph)
  (cond
    [(empty? lph) '()]
    [(cons? lph)
     (cons (replace-phone (first lph)) (replace (rest lph)))]
    ))
; helper function
; Phone -> phone
; change all occurance of area code 713 with 281
(check-expect (replace-phone (make-phone 713 231 3428)) (make-phone 281 231 3428))
(check-expect (replace-phone (make-phone 142 231 3428)) (make-phone 142 231 3428))
(define (replace-phone ph)
  (make-phone
   (if (= (phone-area ph) 713) 281 (phone-area ph))
   (phone-switch ph)
   (phone-four ph)
   ))