;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise_142_6_15) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
; Image n -> boolean
; determine if image is not nxn, return #true
; else return #false
(define (Image-check img n)
  (if
   (and (not (= (image-width img) n)) (not (= (image-height img) n)))
   #true
   #false
   ))
; List Number -> Image/Boolean
; determine if an image in List is not the size of
; nxn
(define (ill-sized? loi n)
  (cond
    [(empty? loi) #f]
    [else (if
          (Image-check (first loi))
          (first loi)
          (ill-sized? (rest loi) n)
       )]
    ))