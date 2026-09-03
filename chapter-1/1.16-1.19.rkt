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
