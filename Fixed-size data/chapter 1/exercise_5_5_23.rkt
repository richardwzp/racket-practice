#lang racket
(require 2htdp/image)
(define radius 20)
(define background (empty-scene 100 100))
(define leaves (circle radius "solid" "green"))
(define trunk (rectangle 10 50 "solid" "brown"))
(define x (* -1 (- (/ 100 2) radius)))
(define y (* -1 (- 50 (* 2 radius))))

(overlay/xy
 leaves
 x y
(overlay/align "middle" "bottom"
               trunk background)
)