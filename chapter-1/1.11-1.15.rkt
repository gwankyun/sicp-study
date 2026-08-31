#lang racket
(require rackunit)
(require racket/trace)
(require racket/contract)

;;; 換零錢方式的統計

(define (count-change amount)
  (cc amount 5))

(define (cc amount kinds-of-coins)
  (cond [(= amount 0) 1] ; 錢為0時，返回1
        [(or (< amount 0) (= kinds-of-coins 0)) 0] ; 錢少於0或幣值不存在時，返回0
        [else (+ (cc amount
                     (- kinds-of-coins 1) #| 不用當前幣值 |#)
                 (cc (- amount
                        (first-denomination kinds-of-coins) #| amount - 當前幣值 |#)
                     kinds-of-coins #| 至少用一個當前幣值 |#))]))

;; 類型對應面額
(define (first-denomination kinds-of-coins)
  (cond [(= kinds-of-coins 1) 1]
        [(= kinds-of-coins 2) 5]
        [(= kinds-of-coins 3) 10]
        [(= kinds-of-coins 4) 25]
        [(= kinds-of-coins 5) 50]))

(time (check-equal? (count-change 100) 292))

;;; 練習 1.11

(define (f n)
  (if (<= n 3)
      n
      (+ (f (- n 1))
         (* 2 (f (- n 2)))
         (* 3 (f (- n 3))))))

(define (f2 n)
  ;; 構造 1 2 3 ... 隊列
  (define (iter c d-3 d-2 d-1)
    ;; d = (d - 1) + 2(d - 2) + 3(d -3)
    (define d (+ d-1
                 (* 2 d-2)
                 (* 3 d-3)))
    (if (= n c)
        d
        (iter (+ c 1) d-2 d-1 d)) #| 每次向後移一位 |#)
  (if (<= n 3)
      n
      (iter 4 1 2 3)))

(check-equal? (f 1) (f2 1))
(check-equal? (f 2) (f2 2))
(check-equal? (f 3) (f2 3))
(check-equal? (f 4) (f2 4))
(check-equal? (f 5) (f2 5))

;;; 練習 1.12

(define (p n k)
  (cond [(<= n 1) 1]
        [(= k 0) 1]
        [(= k n) 1]
        [else (+ (p (- n 1) (- k 1))
                 (p (- n 1) k))]))

(check-equal? (p 0 0) 1)
(check-equal? (p 1 0) 1)
(check-equal? (p 1 1) 1)
(check-equal? (p 2 0) 1)
(check-equal? (p 2 1) 2)
(check-equal? (p 2 2) 1)
(check-equal? (p 3 0) 1)
(check-equal? (p 3 1) 3)
(check-equal? (p 3 2) 3)
(check-equal? (p 3 3) 1)
(check-equal? (p 4 0) 1)
(check-equal? (p 4 1) 4)
(check-equal? (p 4 2) 6)
(check-equal? (p 4 3) 4)
(check-equal? (p 4 4) 1)
