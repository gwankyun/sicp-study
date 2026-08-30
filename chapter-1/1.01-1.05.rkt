#lang racket
(require rackunit)

;;; 練習 1.1

(check-equal? (+ 5 3 4) 12)

(check-equal? (- 9 1) 8)

(check-equal? (/ 6 2) 3)

#;(+ (* 2 4) (- 4 6))
(check-equal? (+ (* 2 4) ; 8
                 (- 4 6) ; -2
                 ) ; 6
              6)

(define a 3)

(define b (+ a 1))

(check-equal? b 4)

#;(+ a b (* a b))
(check-equal? (+ a ; 3
                 b ; 4
                 (* a b) ; 12
                 ) ; 19
              19)

(check-equal? (= a b) #f)


#;(if (and (> b a) (< b (* a b)))
    a
    b)
(check-equal?
 (if (and (> b a) ; #t
          (< b (* a b) ; 12
             ) ; #t
          ) ; #t
     a
     b)
 3)

#;(cond ((= a 4) 6)
      ((= b 4) (+ 6 7 a))
      (else 25))
(check-equal?
 (cond ((= a 4) ; #f
        6)
       ((= b 4) ; #t
        (+ 6 7 a) ; 16
        )
       (else 25))
 16)

#;(+ 2 (if (> b a) b a))
(check-equal?
 (+ 2 (if (> b a) ; #t
          b a) ; 4
    ) ; 6
 6)

;;; 練習 1.2

#;(/ (+ 5 3 (- 2 (- 3 (+ 6 (/ 4 5)))))
   (* 3 (- 6 2) (- 2 7)))

;;; 練習 1.3

(define (min/2 a b)
  (if (< a b)
      a
      b))

(define (square x)
  (* x x))

(define (sum-square a b)
  (+ (square a)
     (square b)))

;; 去掉最小那個
(define (ex-1.3 a b c)
  (cond [(< a b c) (sum-square b c)]
        [(< b a c) (sum-square a c)]
        [(< c a b) (sum-square a b)]))

(check-equal? (ex-1.3 1 2 3) 13)
(check-equal? (ex-1.3 2 1 3) 13)
(check-equal? (ex-1.3 2 3 1) 13)

;;; 練習 1.4

;; 根據 b 是正負數用不同的操作符
(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

(check-equal? (a-plus-abs-b 1 2) 3) 

(check-equal? (a-plus-abs-b 1 -2) 3)

;;; 練習 1.5

(define (p) (p))

(define (test x y)
  (if (= x 0)
      0
      y))

;; 答：
;; 應用序是報 p 沒有定義
;; 正則序返回 0

;; 實際上會卡死
; (test 0 (p))
