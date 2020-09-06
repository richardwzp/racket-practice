;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_327_7_31) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct no-info [])
(define NONE (make-no-info))

(define-struct node [ssn name left right])
; A BT (short for BinaryTree) is one of:
; – NONE
; – (make-node Number Symbol BT BT)
(define tree-1 (make-node 63 'a (make-node 29 'b (make-node 15 'c (make-node 10 'd NONE NONE) (make-node 24 'e NONE NONE)) NONE)
                          (make-node 89 'f (make-node 77 'g NONE NONE) (make-node 95 'h NONE (make-node 99 'i NONE NONE)))))

(define ex '((99 o)
  (77 l)
  (24 i)
  (10 h)
  (95 g)
  (15 d)
  (89 c)
  (29 b)
  (63 a)))

(require 2htdp/abstraction)
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

; [List-of [List Number Symbol]] -> BST
; produce a binary search tree according to the given list
(check-satisfied (create-bst-from-list ex) node?)
(define (create-bst-from-list bstl)
  (local
    ((define (last x) (first (reverse x)))
     ; create sorted list)
     (define sorted-list (sort bstl (lambda (x y) (< (first x) (first y)))))
     ; create the middle node
     (define middle-node (last (for/list ([i (ceiling (/ (length sorted-list) 2))] [j sorted-list])
                           j)))
     )
    (foldl (lambda (x base) (make-bst base (first x) (second x))) (make-bst NONE (first middle-node) (second middle-node)) (remove middle-node sorted-list))
    ))

; REAL F**CKING SIMPLE VERSION THAT TOOK 2 SECONDS
(check-expect (simple-create ex) (make-node
 63
 'a
 (make-node 29 'b (make-node 15 'd (make-node 10 'h (make-no-info) (make-no-info)) (make-node 24 'i (make-no-info) (make-no-info))) (make-no-info))
 (make-node 89 'c (make-node 77 'l (make-no-info) (make-no-info)) (make-node 95 'g (make-no-info) (make-node 99 'o (make-no-info) (make-no-info))))))
(define (simple-create lol)
  (foldr (lambda (x base) (make-bst base (first x) (second x))) NONE lol))

