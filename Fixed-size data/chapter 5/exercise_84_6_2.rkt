;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise_84_6_2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)
; data definition
; (make-editor String String)
(define-struct editor [pre post])
; constant definition
(define CANVAS
  (empty-scene 200 20))
(define CURSOR
  (rectangle 1 20 "solid" "red"))
; render images
; editor -> Image
; generate the word with curser
; inbetween the two strings
(define (insert-curser p)
   (beside
    (text (editor-pre p) 11 "black")
    CURSOR
    (text (editor-post p) 11 "black")
    )
  )
; editor -> Image
; place the word with curser onto the
; background
(define (render word)
  (overlay/align "left" "center"
   (insert-curser word)
   CANVAS
   )
  )
; substring auxiliary functions
; String -> 1String
; take the first character of a string
(check-expect (string-first "hello") "h")
(define (string-first str)
  (string-ith str 0))
; String -> 1String
; take the last character of a string
(check-expect (string-last "hello") "o")
(define (string-last str)
  (string-ith str (- (string-length str) 1) ))
; String -> String
; remove the first character of a string
(check-expect (string-rest "q") "")
(check-expect (string-rest "hello") "ello")
(define (string-rest str)
  (if (= (string-length str) 1)
      ""
      (substring str 1 (string-length str))
      )
  )
; String -> String
; remove last character of string
(check-expect (string-remove-last "q") "")
(check-expect (string-remove-last "hello") "hell")
(define (string-remove-last str)
  (if (= (string-length str) 1)
      ""
      (substring str 0 (- (string-length str) 1))
      ) 
  )
; String -> boolean
; check if the String is empty
(check-expect (string-not-empty? "") #false)
(check-expect (string-not-empty? "hello") #true)
(define (string-not-empty? str)
(if (string=? str "") #false #true))
; editor keyevent -> editor
; move cursor in direction according to
; keyevent
; condition 1: there is character for the cursor to pass over
; condition 2: there is no space and the cursor have to stay in the same place
(check-expect
 (move-cursor (make-editor "hello" "world") "left")
 (make-editor "hell" "oworld")
 )
(check-expect
 (move-cursor (make-editor "hello" "world") "right")
 (make-editor "hellow" "orld")
 )
(check-expect
 (move-cursor (make-editor "hello" "world") "qwe")
 (make-editor "hello" "world")
 )
(define (move-cursor ed ke)
   (cond
    [(and (string=? ke "right") (string-not-empty? (editor-post ed)))
     (make-editor (string-append (editor-pre ed) (string-first (editor-post ed)))
                  (string-rest (editor-post ed))
                  )
    ]
    [(and (string=? ke "left") (string-not-empty? (editor-pre ed)))
     (make-editor (string-remove-last (editor-pre ed))
                  (string-append (string-last (editor-pre ed)) (editor-post ed))
                  )
    ]
    [else ed]
             
   )
  )
; editor -> editor
; delete one character
; condition 1: delete character if there is character
; condition 2: no character and nothing is deleted
(check-expect
(move-back (make-editor "hello" "world"))
(make-editor "hell" "world")
 )
(check-expect
(move-back (make-editor "" "helloworld"))
(make-editor "" "helloworld")
 )
(define (move-back ed)
  (if (string=? (editor-pre ed) "")
      ed
      (make-editor (string-remove-last (editor-pre ed)) (editor-post ed))
      )
  )
; editor key -> editor
; add the string key at the position
; of the cursor
(check-expect
 (move-add (make-editor "hello" "world") "q")
 (make-editor "helloq" "world")
 )
(define (move-add ed ke)
  (make-editor
   (string-append (editor-pre ed) ke)
   (editor-post ed)
   )
  )

; editor keyevent -> editor
; the editor is revised acording to keyevents
; left: cursor move left
; right: cursor move right
; backspace: delete one character to the left
; random character: add char at cursor
; else(icnludes tab and enter): return original
(define te (make-editor "hello" "world"))
(check-expect (edit te "left") (make-editor "hell" "oworld"))
(check-expect (edit te "\b") (make-editor "hell" "world"))
(check-expect (edit te "q") (make-editor "helloq" "world"))
(check-expect (edit te "\t") (make-editor "hello" "world"))
(check-expect (edit te "nonsense") (make-editor "hello" "world"))
(define (edit ed ke)
  (cond
    [(> (string-length ke) 1) (move-cursor ed ke)]
    [(string=? ke "\b") (move-back ed)]
    [(or (string=? ke "\t") (string=? ke "\r")) ed]
    [(= (string-length ke)) (move-add ed ke)]
    )
  )
(define (main holder)
  (big-bang (make-editor "helloworld" "")
    [to-draw render]
    [on-key edit]
      )
  )