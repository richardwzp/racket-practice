;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_324_7_31) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct no-info [])
(define NONE (make-no-info))
 
(define-struct node [ssn name left right])
; A BT (short for BinaryTree) is one of:
; – NONE
; – (make-node Number Symbol BT BT)
(define tree-1 (make-node 63 'a (make-node 29 'b (make-node 15 'c (make-node 10 'd NONE NONE) (make-node 24 'e NONE NONE)) NONE)
                          (make-node 89 'f (make-node 77 'g NONE NONE) (make-node 95 'h NONE (make-node 99 'i NONE NONE)))))

; Number BT -> name || False
; search the tree for ssn Number, if not found return false
(check-expect (inorder tree-1) `(10 15 24 29 63 77 89 95 99))
(define (inorder bt)
  (cond
    [(no-info? bt) '()]
    [else (append (inorder (node-left bt)) `(,(node-ssn bt)) (inorder (node-right bt)))]))

