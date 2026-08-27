#lang racket
(require rackunit)
(require racket/trace)
(require racket/contract)

;;; 練習 1.9

(define (inc x)
  (+ x 1))

(define (dec x)
  (- x 1))

(define (ex1.9-a/+ a b)
  (if (= a 0)
      b
      (inc (+ (dec a) b))))

(check-equal? (ex1.9-a/+ 4 5) 9)

; 計算過程
(inc (+ 3 5))
(inc (inc (+ 2 5)))
(inc (inc (inc (+ 1 5))))
(inc (inc (inc (inc (+ 0 5)))))
(inc (inc (inc (inc 5))))
(inc (inc (inc 6)))
(inc (inc 7))
(inc 8)
9
; 是遞歸計算過程

(define (ex1.0-b/+ a b)
  (if (= a 0)
      b
      (+ (dec a) (inc b))))

; 計算過程
(+ 3 6)
(+ 2 7)
(+ 1 8)
(+ 0 9)
9
; 是迭代計算過程

;;; 練習 1.10

(define (A x y)
  (cond [(= y 0) 0]
        [(= x 0) (* 2 y)]
        [(= y 1) 2]
        [else (A (- x 1)
                 (A x (- y 1)))]))

(A 1 10)
(A 0 (A 1 9)) ; 1 9
(A 0 (A 0 (A 1 8))) ; 1 8
(A 0 (A 0 (A 0 (A 1 7)))) ; 1 7
(A 0 (A 0 (A 0 (A 0 (A 1 6))))) ; 1 6
(A 0 (A 0 (A 0 (A 0 (A 0 (A 1 5)))))) ; 1 5
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 4))))))) ; 1 4
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 3)))))))) ; 1 3
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 2))))))))) ; 1 2
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 1)))))))))) ; 1 1
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 2))))))))) ; 0 2
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 4)))))))) ; 0 4
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 8))))))) ; 0 8
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 16)))))) ; 0 16
(A 0 (A 0 (A 0 (A 0 (A 0 32))))) ; 0 32
(A 0 (A 0 (A 0 (A 0 64)))) ; 0 64
(A 0 (A 0 (A 0 128))) ; 0 128
(A 0 (A 0 256)) ; 0 256
(A 0 512) ; 0 512
1024

(check-equal? (A 1 10) 1024)

(A 2 4) ; 2 4
(A 1 (A 2 3)) ; 2 3
(A 1 (A 1 (A 2 2))) ; 2 2
(A 1 (A 1 (A 1 (A 2 1)))) ; 2 1
(A 1 (A 1 (A 1 2))) ; 1 2
(A 1 (A 1 (A 0 (A 1 1)))) ; 1 2
(A 1 (A 1 (A 0 2))) ; 0 2
(A 1 (A 1 4)) ; 1 4
(A 1 (A 0 (A 1 3))) ; 1 3
(A 1 (A 0 (A 0 (A 1 2)))) ; 1 2
(A 1 (A 0 (A 0 (A 0 (A 1 1))))) ; 1 1
(A 1 (A 0 (A 0 (A 0 2)))) ; 0 2
(A 1 (A 0 (A 0 4))) ; 0 4
(A 1 (A 0 8)) ; 0 8
(A 1 16) ; 1 16
(A 0 (A 1 15)) ; 1 15
(A 0 (A 0 (A 1 14))) ; 1 14
(A 0 (A 0 (A 0 (A 1 13)))) ; 1 13
(A 0 (A 0 (A 0 (A 0 (A 1 12))))) ; 1 12
(A 0 (A 0 (A 0 (A 0 (A 0 (A 1 11)))))) ; 1 11
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 10))))))) ; 1 10
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 9)))))))) ; 1 9
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 8))))))))) ; 1 8
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 7)))))))))) ; 1 7
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 6))))))))))) ; 1 6
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 5)))))))))))) ; 1 5
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 4))))))))))))) ; 1 4
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 3)))))))))))))) ; 1 3
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 2))))))))))))))) ; 1 2
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 1)))))))))))))))) ; 1 1
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 2))))))))))))))) ; 0 2
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 4))))))))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 8)))))))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 16))))))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 32)))))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 64))))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 128)))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 256))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 512)))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 1024))))))
(A 0 (A 0 (A 0 (A 0 (A 0 2048)))))
(A 0 (A 0 (A 0 (A 0 4096))))
(A 0 (A 0 (A 0 8192)))
(A 0 (A 0 16384))
(A 0 32768)
65536

(check-equal? (A 2 4) 65536)

(A 3 3) ; 3 3
(A 2 (A 3 2)) ; 3 2
(A 2 (A 2 (A 3 1))) ; 3 1
(A 2 (A 2 2)) ; 2 2
(A 2 (A 1 (A 2 1))) ; 2 1
(A 2 (A 1 2)) ; 1 2
(A 2 (A 0 (A 1 1))) ; 1 1
(A 2 (A 0 2)) ; 0 2
(A 2 4) ; 2 4
65536

(check-equal? (A 3 3) 65536)

; n * 2
(define (f n) (A 0 n))

(define (f2 n)
  (if (= n 0)
      0
      (* n 2)))

(check-equal? (f 0) (f2 0))
(check-equal? (f 1) (f2 1))
(check-equal? (f 3) (f2 3))
(check-equal? (f 10) (f2 10))

; 2^n
(define (g n) (A 1 n))

; b的n次方
(define (pow b n)
  (define (iter r c)
    (if (= c 0)
        r
        (iter (* r b) (- c 1))))
  (iter 1 n))

(define (g2 n)
  (if (= n 0)
      0
      (pow 2 n)))

(check-equal? (g 0) (g2 0))
(check-equal? (g 1) (g2 1))
(check-equal? (g 3) (g2 3))
(check-equal? (g 10) (g2 10))

; 2^(h (n - 1))
(define (h n) (A 2 n))

#|
(A 1 (A 2 (- n 1)))
(A 1 (A 1 (A 2 (- n 2))))
|#

(define (h2 n)
  (define (iter r c)
    (if (= c 0)
        r
        (iter (pow 2 r) (- c 1))))
  (if (= n 0)
      0
      (iter 1 n)))

(check-equal? (h 1) (h2 1))
(check-equal? (h 2) (h2 2))
(check-equal? (h 3) (h2 3))
(check-equal? (h 4) (h2 4))
