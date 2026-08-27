#lang racket
(require rackunit)
(require racket/trace)
(require racket/contract)

;;; 1.1.7 書上代碼

;; x 與 y 的平均
(define (average x y)
  (/ (+ x y) 2))

;; 算更好值
(define (improve guess x)
  (average guess (/ x guess)))

;; 平方
(define (square x)
  (* x x))

;; 平方和原值相比
(define (good-enough? guess x)
  (< (abs (- (square guess) x #| guess ^ 2 與 x 之差 |#))
     0.001))

;; 迭代算值
(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x) x)))

(define (sqrt x)
  (sqrt-iter 1.0 x))

;; 提前用到 let
(let ([s sqrt]
      [tol 0.001])
  (check-= (sqrt 9) 3.0 tol)
  (check-= (sqrt (+ 100 37)) 11.7047 tol)
  (check-= (sqrt (+ (sqrt 2) (sqrt 3))) 1.7739 tol)
  (check-= (square (sqrt 1000)) 1000 tol)
  )

;;; 練習 1.6

;; 會列循環，因為不會短路

;;; 練習 1.7

#|
數太小了,0.001精度不夠
數太大了,平方會溢出
|#

(define (abs-diff x y)
  (abs (- x y)))

(define (ex/max a b)
  (if (>= a b)
      a
      b))

;; 結合絕對誤差和相對誤差
(define (ex/good-enough? guess x)
  #;(< (/ (abs-diff prev next) prev)
     0.001)
  ; abs(prev - next) < max(e_abs, e_rel * prev)
  (< (abs-diff (square guess) x)
     (ex/max 0.001 (* 0.001 (square guess))))
  )

(define/contract (ex/sqrt-iter guess x)
  (-> number? number? number?)
  (if (ex/good-enough? guess x)
      guess
      (ex/sqrt-iter (improve guess x) x)))

(trace ex/sqrt-iter)

(define (ex/sqrt x)
  (ex/sqrt-iter 1.0 x))

(ex/sqrt 9)

;; 提前用到 let
(let ([s ex/sqrt]
      [tol 0.001])
  (check-= (sqrt 9) 3.0 tol)
  (check-= (sqrt (+ 100 37)) 11.7047 tol)
  (check-= (sqrt (+ (sqrt 2) (sqrt 3))) 1.7739 tol)
  (check-= (square (sqrt 1000)) 1000 tol)
  )

;;; 練習 1.8

(define (ex-1.8/improve guess x)
  (/ (+ (/ x (square guess)) (* 2 guess)) 3))

(define (ex-1.8/sqrt-iter guess prev x)
  (if (ex/good-enough? guess prev)
      guess
      (ex/sqrt-iter (ex-1.8/improve guess x) x)))

(trace ex-1.8/sqrt-iter)

(define (ex-1.8/sqrt x)
  (ex-1.8/sqrt-iter 1.0 x x))

(let ([s ex-1.8/sqrt]
      [tol 0.001])
  (check-= (sqrt 9) 3.0 tol)
  (check-= (sqrt (+ 100 37)) 11.7047 tol)
  (check-= (sqrt (+ (sqrt 2) (sqrt 3))) 1.7739 tol)
  (check-= (square (sqrt 1000)) 1000 tol)
  )

(ex-1.8/sqrt 9) ; 更少的迭代
