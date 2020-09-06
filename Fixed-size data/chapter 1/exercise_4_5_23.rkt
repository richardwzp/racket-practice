#lang racket
(define str "helloworld")
(define i 5)
(string-append (substring str 0 (- i 1)) (substring str i (string-length str)))