#lang racket
(require rackunit)
(require racket/trace)
(require racket/contract)

;;; 練習 1.14

;; 指數級

;;; 練習 1.15

(define (cube x) (* x x x))

(define (p x)
  (- (* 3 x)
     (* 4 (cube x))))

(define (sine angle)
  (if (not (> (abs angle) 0.1))
      angle
      (p (sine (/ angle 3.0)))))

;; a)，5次，如下

(define r (sine 12.15))
(define tol 0.001)
(check-= (p (sine (/ 12.15 3))) r tol) ; 4.05
(check-= (p (p (sine (/ 4.05 3)))) r tol) ; 1.35
(check-= (p (p (p (sine (/ 1.35 3))))) r tol) ; 0.45
(check-= (p (p (p (p (sine (/ 0.45 3)))))) r tol) ; 0.15
(check-= (p (p (p (p (p (sine (/ 0.15 3))))))) r tol) ; 0.05
(check-= (p (p (p (p (p 0.05))))) r tol)

;; b) 大概是logn？
