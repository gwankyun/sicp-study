#lang racket
(require rackunit)
(require racket/trace)
(require racket/contract)

;;; 練習 1.16

(define (even? n)
  (= (remainder n 2) 0))

(check-equal? (even? 1) #f)
(check-equal? (even? 0) #t)

(define (square n)
  (* n n))

(define (fast-expt b n)
  (cond [(= n 0) 1]
        [(even? n) (square (fast-expt b (/ n 2)))]
        [else (* b (fast-expt b (- n 1)))]))

(check-equal? (fast-expt 3 0) 1)
(check-equal? (fast-expt 1 3) 1)
(check-equal? (fast-expt 2 3) 8)
(check-equal? (fast-expt 2 4) 16)

(define (fast-expt-iter b n)
  (define (iter a b n)
    (cond [(= n 0) a]
          [(even? n) (iter a (square b) (/ n 2))]
          [else (iter (* a b) b (- n 1))]))
  (iter 1 b n))

(check-equal? (fast-expt-iter 3 0) 1)
(check-equal? (fast-expt-iter 1 3) 1)
(check-equal? (fast-expt-iter 2 3) 8)
(check-equal? (fast-expt-iter 2 4) 16)

;;; 練習 1.17

(define (double n) (+ n n))

(define (halve n) (/ n 2))

(define (fast-mul a b)
  (define (iter i a b)
    (cond [(= b 0) i]
          [(even? b) (iter i (double a) (halve b))]
          [else (iter (+ i a) a (- b 1))]))
  (iter 0 a b))

(check-equal? (fast-mul 0 0) 0)
(check-equal? (fast-mul 2 3) 6)

;;; 練習 1.18

;; 直接用1.17的即可。

;;; 練習 1.19

(define (fib-iter a b p q count)
  (cond [(= count 0) b]
        [(even? count)
         (fib-iter a
                   b
                   (+ (square p)
                      (square q))
                   (+ (* 2 p q)
                      (square q))
                   (/ count 2))]
        [else (fib-iter (+ (* b q) (* a q) (* a p))
                        (+ (* b p) (* a q))
                        p
                        q
                        (- count 1))]))

(define (fib n)
  (fib-iter 1 0 0 1 n))

(check-equal? (fib 0) 0)
(check-equal? (fib 1) 1)
(check-equal? (fib 2) 1)
(check-equal? (fib 3) 2)
(check-equal? (fib 4) 3)
(check-equal? (fib 5) 5)
(check-equal? (fib 6) 8)
