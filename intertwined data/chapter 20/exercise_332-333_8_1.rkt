;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_329_8_1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; A Dir.v2 is a structure: 
;   (make-dir String LOFD)
(define-struct Dir.v2 [name content])
; An LOFD (short for list of files and directories) is one of:
; – '()
; – (cons File.v2 LOFD)
; – (cons Dir.v2 LOFD)
 
; A File.v2 is a String.

(define sample-dir-tree.v2 `(,(make-Dir.v2 "TS" `(,(make-Dir.v2 "Text" `("part1" "part2" "part3")) "read!" ,(make-Dir.v2 "Libs" `(,(make-Dir.v2 "Code" `("hang" "draw")) ,(make-Dir.v2 "Docs" `("read!"))))))))

; LOFD -> Number
; count how many files there are in LOFD
(check-expect (how-many sample-dir-tree.v2) 7)
(define (how-many lofd)
  (cond
    [(empty? lofd) 0]
    [(string? (first lofd)) (+ 1 (how-many (rest lofd)))]
    [else (+ (how-many (Dir.v2-content (first lofd))) (how-many (rest lofd)))]))