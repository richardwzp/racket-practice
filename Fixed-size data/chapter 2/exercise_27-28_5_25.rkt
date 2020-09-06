#lang racket
(define original_price 5)
(define price_scale 0.10)
(define original_attendence 120)
;amount of people change per price unit
(define atten_chg 15)
(define (attendence ticket_price)
  (-
   original_attendence
   (* atten_chg (/ (- ticket_price original_price) price_scale)))
  )


(define (revenue ticket_price)
  (* ticket_price (attendence ticket_price))
  )


(define fixed_cost 180)
(define avg_var_cost 0.04)
(define (cost ticket_price)
  (+ fixed_cost (* avg_var_cost (attendence ticket_price)))
  )


(define (profit ticket_price)
  (- (revenue ticket_price) (cost ticket_price))
  )
