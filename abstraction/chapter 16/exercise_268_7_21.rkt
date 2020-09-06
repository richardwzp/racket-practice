;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise_268_7_21) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; an inventory is a structure of:
; (make-inventory item String Number Number)
(define-struct inventory [item description ac-price sales-price])

; [list-of inventory] -> [list-of inventory]
; sort the list according to the difference between ac-price and sales-price
(check-expect (inven-sort `( ,(make-inventory "item1" "hehe" 10 5) ,(make-inventory "item2" "hehe" 2 5) ,(make-inventory "item3" "hehe" 50 5)))
              `( ,(make-inventory "item3" "hehe" 50 5) ,(make-inventory "item1" "hehe" 10 5) ,(make-inventory "item2" "hehe" 2 5)))

(define (inven-sort loi)
  (local
    (; inventory inventory -> boolean
     ; compare the difference between ac-price and sales-price between the two inventory
     (define (greater-price? inven1 inven2)
       (local
         ; inventory -> number (difference between ac price and sales price)
         ((define (difference inven) (- (inventory-ac-price inven) (inventory-sales-price inven))))
         (>= (difference inven1) (difference inven2))))
     )
    (sort loi greater-price?)
    ))