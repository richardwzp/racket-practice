#lang racket
(require 2htdp/image)
(define in #true)

(define (str_len str) (string-length str))
(define (img_area img) (* (image-height img) (image-width img)))
(define (num num_x)
  (if (= num_x 0) 0 (- num_x 1))
  )
(define (bool_num bool)
  (if in 10 20)
  )

(define exercise 
(cond
  [(string? in) (string-length in)]
  [(image? in) (img_area in)]
  [(number? in) (num in)]
  [(boolean? in) (bool_num in)]
 )
)