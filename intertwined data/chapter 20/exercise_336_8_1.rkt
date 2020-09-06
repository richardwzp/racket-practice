;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_336_8_1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define-struct file [name size content])
; A File.v3 is a structure: 
;   (make-file String N String)

(define-struct dir.v3 [name dirs files])
; A Dir.v3 is a structure: 
;   (make-dir.v3 String Dir* File*)
 
; A Dir* is one of: 
; – '()
; – (cons Dir.v3 Dir*)
 
; A File* is one of: 
; – '()
; – (cons File.v3 File*)


(define sample-tree.v3 (make-dir.v3 "TS" `(,(make-dir.v3 "Text" '() `(,(make-file "part1" 99 "") ,(make-file "part2" 52 "") ,(make-file "part3" 17 "")))
                                           ,(make-dir.v3 "Libs" `(,(make-dir.v3 "Code" '() `(,(make-file "hang" 8 "") ,(make-file "draw" 2 ""))) ,(make-dir.v3 "Docs" '() `(,(make-file "read!" 19 "")))) '())) `(,(make-file "read!" 10 ""))))


; Dir.v3 -> Number
(check-expect (how-many sample-tree.v3) 7)
(define (how-many dir)
  (local
    (; File* -> Number
     ; process files
     (define (how-many-file files)
       (length files))
     ; Dir* -> Number
     ; process directories
     (define (how-many-in-dir dirs)
       (cond
         [(empty? dirs) 0]
         [else (+ (dir-number (first dirs)) (how-many-in-dir (rest dirs)))]))
     ; Dir.v3 -> Number
     ; directory process
     (define (dir-number dir) (cond
    [(empty? dir) 0]
    [(dir.v3? dir) (+ (how-many-in-dir (dir.v3-dirs dir)) (how-many-file (dir.v3-files dir)))]))
     )
    (dir-number dir)
    ))