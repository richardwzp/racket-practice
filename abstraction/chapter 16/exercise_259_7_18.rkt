;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise_259_7_18) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define (string-to-list str)
  (cond
    [(string=? str "") '()]
    [else (cons (string-ith str 0) (string-to-list (substring str 1 (string-length str))))]))

(define (list-to-string l)
  (cond
    [(empty? l) ""]
    [else (string-append (first l) (list-to-string (rest l)))]))


(define (arrangement str)
  (local 
   (; 1. convert the string to a list
    (define list-of-string (string-to-list str))
    
    ; 2. insert letter everywhere
    (define (insert-everywhere in-1str in-str)
      (local
      (
      ; 2-2. insertion insert letter at position n
      (define (insertion n)
        (string-append
         (substring in-str 0 n)
         in-1str
         (substring in-str n (string-length in-str))))
      ; 2-3. insert letter for single word, return a list of all posibility
      (define (insert-word w) (if (string=? w "") (list in-1str) (build-list (add1 (string-length w)) insertion))))
        
      ; 2-main: insert everywhere expression
        (insert-word in-str)
        )) 
     ; 3. insert everywhere in all words
    (define (insert-everywhere/in-all-words ev-1str ev-lstr)
      (local
        ((define (ff l1 l2) (append (insert-everywhere ev-1str l1) l2)))
        (if (empty? ev-lstr) (list ev-1str) (foldr ff '() ev-lstr))
        ))
     ; 4. creat arrangement 
    (define (arrangements w)
  (cond
    [(empty? w) '()]
    [else (insert-everywhere/in-all-words (first w)
            (arrangements (rest w)))]))
    
     
    )
    ; main: function expression
    (arrangements list-of-string)
    ;(insert-everywhere/in-all-words (string-ith str 0) (list (substring str 1 (string-length str))))
    ))




