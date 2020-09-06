;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_340_8_15) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require htdp/dir)
(define O (create-dir "/Users/wzp/Desktop/html/"))

; Directory -> [list-of names]
(check-expect (ls O) (list
 '/Users/wzp/Desktop/html/.vscode
 '/Users/wzp/Desktop/html/css
 '/Users/wzp/Desktop/html/img
 '/Users/wzp/Desktop/html/learning
 ".DS_Store"
 "about.html"
 "contact.html"
 "index.html"
 "learn.html"
 "resource.html"))
(define (ls di)
  (append
   (map (lambda (d) (dir-name d)) (dir-dirs di))
   (map (lambda (d) (file-name d)) (dir-files di))))