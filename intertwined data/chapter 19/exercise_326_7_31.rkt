;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_326_7_31) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct no-info [])
(define NONE (make-no-info))

(define-struct node [ssn name left right])
; A BT (short for BinaryTree) is one of:
; – NONE
; – (make-node Number Symbol BT BT)
(define tree-1 (make-node 63 'a (make-node 29 'b (make-node 15 'c (make-node 10 'd NONE NONE) (make-node 24 'e NONE NONE)) NONE)
                          (make-node 89 'f (make-node 77 'g NONE NONE) (make-node 95 'h NONE (make-node 99 'i NONE NONE)))))

; BST-B N S -> BST
; replace one NONE node with
; (make-node N S NONE NONE)
; preserve the shape of a BST
(check-satisfied (make-bst tree-1 100 'j) node?)
(check-satisfied (make-bst tree-1 20 'j) node?)
(define (make-bst b n s)
  (cond
    [(no-info? b) (make-node n s NONE NONE)]
    [(< n (node-ssn b)) (make-node (node-ssn b) (node-name b) (make-bst (node-left b) n s) (node-right b))]
    [else (make-node (node-ssn b) (node-name b) (node-left b) (make-bst (node-right b) n s))]))


