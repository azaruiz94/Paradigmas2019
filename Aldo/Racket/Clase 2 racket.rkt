#lang racket
 (require racket/trace)
(define (dobles lista)
  (cond [(null? lista) null]
        [(not (number? (car lista))) (dobles (cdr lista))]
        [else (cons (* 2 (car lista)) (dobles (cdr lista)))]))

(define (duplicado lista)
  (cond [(null? lista) null]
        [(not (number? (car lista))) (dobles empty)]
        [else (cons (* 2 (car lista)) (duplicado (cdr lista)))]))

(define (crear-lista num elemento)
  (cond [(zero?) num]
        [else (cons elemento (crear-lista (- num 1) elemento))]))

;contar-pares '(1 2 3 a 4 5b)
(define (contar-pares lista) 
  (cond [(empty? lista) 0]
        [(not (number? (car lista))) (contar-pares(cdr lista))]
        [(= 0 (modulo (car lista) 2)) (+ 1 (contar-pares(cdr lista)))]))
(trace contar-pares)


