;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise_165_6_18) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; List-of-string -> List-of-string
; replace all occurance of robot with r2d2
(check-expect (subst-robot (cons "rocket" (cons "robot" '()))) (cons "rocket" (cons "r2d2" '())))
(define (subst-robot ltoy)
        (cond
          [(empty? ltoy) '()]
          [(cons? ltoy)
          (cons (replace-robot (first ltoy)) (subst-robot (rest ltoy)))]
          ))
; String -> String
; replace robot with r2d2,
; else string remain the same
(check-expect (replace-robot "robot") "r2d2")
(check-expect (replace-robot "rocket") "rocket")
(define (replace-robot r)
  (if (string=? r "robot") "r2d2" r))

; List-of-string -> List-of-string
; replace all occurance of old with new
(check-expect (substitute "rocket" "hehe"(cons "rocket" (cons "robot" '()))) (cons "hehe" (cons "robot" '())))
(define (substitute old new ltoy)
        (cond
          [(empty? ltoy) '()]
          [(cons? ltoy)
          (cons (replace-word old new (first ltoy)) (substitute old new (rest ltoy)))]
          ))
; String -> String
; replace robot with r2d2,
; else string remain the same
(check-expect (replace-word "robot" "r2d2" "robot") "r2d2")
(check-expect (replace-word "robot" "hehe" "rocket") "rocket")
(define (replace-word old new r)
  (if (string=? r old) new r))
