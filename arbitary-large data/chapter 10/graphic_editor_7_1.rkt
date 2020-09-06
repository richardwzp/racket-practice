;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname graphic_editor_7_1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)
(define-struct editor [pre post])
; An Editor is a structure:
;   (make-editor Lo1S Lo1S) 
; An Lo1S is one of: 
; – '()
; – (cons 1String Lo1S)
(define CANVAS
  (empty-scene 200 20))
(define CURSOR
  (rectangle 1 20 "solid" "red"))
(define FONT-SIZE 11)
(define FONT-COLOR "black")
; create-editor helper
; String -> List
; convert a string to a list
(check-expect (string_to_list "abc") (cons "a" (cons "b" (cons "c" '()))))
(define (string_to_list l)
  (cond
    [(string=? l "") '()]
    [else
     (cons (string-ith l 0) (string_to_list (substring l 1 (string-length l))))
     ]))
; String String -> editor
; consume two strings and create an editor
(check-expect (create-editor "ab" "cd")
              (make-editor
               (cons "b" (cons "a" '()))
               (cons "c" (cons "d" '()))))
(define (create-editor str1 str2)
  (make-editor
   (reverse (string_to_list str1))
   (string_to_list str2)
   ))
; editor-render helper function
; Lo1s -> Image
; renders a list of 1Strings as a text image
(check-expect
  (editor-text
   (cons "p" (cons "o" (cons "s" (cons "t" '())))))
  (text "post" FONT-SIZE FONT-COLOR))
(define (editor-text s)
  (text (implode s) FONT-SIZE FONT-COLOR))
; Editor -> Image
; renders an editor as an image of the two texts 
; separated by the cursor 
; Editor -> Image
(define (editor-render e)
  (place-image/align
    (beside (editor-text (reverse (editor-pre e)))
            CURSOR
            (editor-text (editor-post e)))
    1 1
    "left" "top"
    CANVAS))

; keyEvent Helper function
; Editor -> Editor
; move the cursor 1 to the left
(check-expect (editor-lft (create-editor "" "")) (create-editor "" ""))
(check-expect (editor-lft (create-editor "ab" "cd")) (create-editor "a" "bcd"))
(define (editor-lft ed)
  (if
   (empty? (editor-pre ed))
   ed
   (make-editor
    (rest (editor-pre ed))
    (cons (first (editor-pre ed)) (editor-post ed))
    )
   ))

; keyEvent Helper function
; Editor -> Editor
; move the cursor 1 to the right
(check-expect (editor-rgt (create-editor "" "")) (create-editor "" ""))
(check-expect (editor-rgt (create-editor "ab" "cd")) (create-editor "abc" "d"))
(define (editor-rgt ed)
  (if
   (empty? (editor-post ed))
   ed
   (make-editor
    (cons (first (editor-post ed)) (editor-pre ed))
    (rest (editor-post ed))
    )))

; keyEvent Helper function
; Editor -> Editor
; remove 1 character from pre
(check-expect (editor-del (create-editor "" "")) (create-editor "" ""))
(check-expect (editor-del (create-editor "ab" "cd")) (create-editor "a" "cd"))
(define (editor-del ed)
  (if
   (empty? (editor-pre ed))
   ed
   (make-editor
    (rest (editor-pre ed))
    (editor-post ed)
    )))

; keyEvent Helper function
; Editor String -> Editor
; insert the 1String k between pre and post
(check-expect
  (editor-ins (make-editor '() '()) "e")
  (make-editor (cons "e" '()) '()))
 
(check-expect
  (editor-ins
    (create-editor "d" "fg") "e")
  (create-editor "de" "fg"))

(define (editor-ins ed k)
  (make-editor
   (cons k (editor-pre ed))
   (editor-post ed)))
; Editor KeyEvent -> Editor
; deals with a key event, given some editor
(check-expect (editor-kh (create-editor "" "") "e")
              (create-editor "e" ""))
(check-expect
  (editor-kh (create-editor "cd" "fgh") "e")
  (create-editor "cde" "fgh"))
(define (editor-kh ed k)
  (cond
    [(key=? k "left") (editor-lft ed)]
    [(key=? k "right") (editor-rgt ed)]
    [(key=? k "\b") (editor-del ed)]
    [(key=? k "\t") ed]
    [(key=? k "\r") ed]
    [(= (string-length k) 1) (editor-ins ed k)]
    [else ed]))

; main : String -> Editor
; launches the editor given some initial string 
(define (main s)
   (big-bang (create-editor s "")
     [on-key editor-kh]
     [to-draw editor-render]))
