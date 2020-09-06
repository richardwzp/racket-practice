;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_339_8_15) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require htdp/dir)
(define O (create-dir "/Users/wzp/Desktop/html/"))

; directory String -> Boolean
; determine whether the file is inside the directory
(check-expect (find? O "style.css") #t)
(check-expect (find? O "sty") #f)
(define (find? d fn)
  (local
    (; [list-of files] -> Boolean
    ; if the file is in directory
    (define (find-file? lof)
      (ormap (lambda (x) (string=? (file-name x) fn)) lof))
    ;directory String -> Boolean
    (define (travel-dir d fn)
      (cond
        [(file? d) (string=? fn (file-name d))]
        [(dir? d)
         (or (find-file? (dir-files d)) (ormap (lambda (x) (travel-dir x fn)) (dir-dirs d)))])))
    (travel-dir d fn)
    ))