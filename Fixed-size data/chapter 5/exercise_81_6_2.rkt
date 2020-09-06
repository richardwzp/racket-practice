;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise_81_6_2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct clock [hour minute second])

; 3p -> Number
; convert hours, minutes, and seconds
; into seconds
(check-expect
 (time->seconds (make-clock 12 30 2))
 45002
 )
(define (time->seconds t)
  (+
   (* (clock-hour t) 60 60)
   (* (clock-minute t) 60)
   (clock-second t)
   )
  )
