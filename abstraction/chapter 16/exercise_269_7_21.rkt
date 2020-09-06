;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise_269_7_21) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; an inventory is a structure of:
; (make-inventory item String Number Number)
(define-struct inventory [item description ac-price sales-price])


; Number [list-of inventory] -> [list-of inventory]
; eliminate inventory with sales-price higher than number ua
(check-expect (eliminate-expensive 10 `(,(make-inventory "item1" "hehe" 5 20) ,(make-inventory "item1" "hehe" 5 3) ,(make-inventory "item1" "hehe" 5 9)))
              `(,(make-inventory "item1" "hehe" 5 3) ,(make-inventory "item1" "hehe" 5 9)))
(define (eliminate-expensive ua loi)
  (local
    (; inventory -> boolean
     ; determine if the inventory price is above threshhold ua
     (define (expensive? inven) (< (inventory-sales-price inven) ua)))
    (filter expensive? loi)
    ))

; String [list-of inventory] -> [list-of inventory]
; produce a list of inventory that has no inventory with the name ty
(check-expect (recall "joker" `(,(make-inventory "joker" "hehe" 5 20) ,(make-inventory "item2" "hehe" 5 3) ,(make-inventory "item3" "hehe" 5 9)))
              `(,(make-inventory "item2" "hehe" 5 3) ,(make-inventory "item3" "hehe" 5 9)))
(define (recall ty loi)
  (local
    (; inventory -> Boolean
     ; determine if the name of the inventory is not ty
     (define (name-is-ty? inven) (not (string=? ty (inventory-item inven)))))
    
    (filter name-is-ty? loi)
    ))

; [list-of name] [list-of name] -> [list-of name]
; choose names that are also on the first as well as the second list
(check-expect (selection `( "q" "w" "e" "r") `("q" "w" "a" "r" "f"))
              `( "q" "w" "r"))
(define (selection lon1 lon2)
  (local
    (; String -> Boolean
     ; determine if name is part of list 1
     (define (member-of-first? name) (member? name lon1)))
    (filter member-of-first? lon2)
    ))