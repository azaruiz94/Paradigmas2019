#lang racket
;(require math/number-theory)
;Ejercicio1
;(obtener-primos '(1 2 3 4 5 6 7 8 9 10 11 12 13))
;'(2 3 5 7 11 13)
(define (es-primo numero)
   (cond [(equal? (length (filter (lambda (x) (equal? x #t)) (map (lambda (x) (cond[(equal? (modulo numero x) 0) #t])) (build-list numero (lambda (x) (+ x 1)))))) 2) #t]
         [else #f]))
(define (obtener-primos lista)
  (filter (lambda (x) (es-primo x)) lista))

;Ejercicio2
;(ordenar 'min-max '(8 5 6 4))
;(4 5 6 8)
(define (ordenar sentido lista)
  (cond[(equal? sentido 'min-max) (sort lista <)]
       [(equal? sentido 'max-min) (sort lista >)]))

;Ejercicio3
;(reducir (mayor-que 5) '(1 2 3 4 5 6 7))
;(6 7)
(define (mayor-que n)
  (lambda (x) (> x n)))
(define (reducir funcion lista)
  (filter funcion lista))

;Ejercicio4
(define (factorial lista)
  (map (lambda (x) (apply * (build-list x (lambda (y) (+ y 1))))) (filter (lambda (x) (< x 20)) lista)))

;Ejercicio5
;(raiz-exacta '(9 16 25 32 64 21))
;(9 16 25 64)
(define (raiz-exacta lista)
  (map (lambda (x) (* x x)) (filter (lambda (x) (integer? x)) (map sqrt lista))))

;Ejercicio6
;(media '(1 2 1 4 2 1 8))
;2.71
;(mediana '(1 2 1 4 2 1 8))
;2
;(moda '(1 2 1 4 2 1 8))
;1

(define (media lista)
  (/ (apply + lista) (length lista)))
;lista ordenada = '(1 1 1 2 2 4 8)
(define (mediana lista)
  (list-ref (ordenar 'min-max lista) (exact-round (/ (length lista) 2))))

(define (moda lista)
  (andmap (lambda (x) x ) (map (lambda (x) (contar-cantidad x lista)) lista)))

(define (contar-cantidad numero lista)
  (define (contar-cantidad-aux numero lista resultado)
    (cond[(empty? lista) resultado ]
         [(equal? (car lista) numero) (contar-cantidad-aux numero (cdr lista) (+ 1 resultado))]
         [else (contar-cantidad-aux numero (cdr lista) resultado)]))
  (contar-cantidad-aux numero lista 0))
  

