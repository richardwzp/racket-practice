;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_341_8_19) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require htdp/dir)
(define O (create-dir "/Users/wzp/Desktop/html/"))

(check-expect (find O "bird.png") "/Users/wzp/Desktop/html/img/bird.png")
(check-expect (find O "bir.png") #f)
(define (find d fn)
     (local
       (; [list-of file] filename [list-of String] -> path/#f
        (define (find-file lof fn path)
          (cond
            [(empty? lof) #f]
            [(string=? (file-name (first lof)) fn) (string-append (symbol->string path) "/" fn)]
            [else (find-file (rest lof) fn path)]))
        ; a [list-of String] or #false
        (define file-result (find-file (dir-files d) fn (dir-name d)))
        ; [list-of directory] -> path/#f
        (define list-of-directory-result
          (filter string?
                  (map
                   (lambda (x) (find x fn))
                   (dir-dirs d))))
        
        ) 
       (cond 
         [(string? file-result) file-result]
         [(empty? list-of-directory-result) #f]
         [else (first list-of-directory-result)]
         )
       ))


; the second challenge is easily achieved, by changing the last else statement to
; [else list-of-directory-result]