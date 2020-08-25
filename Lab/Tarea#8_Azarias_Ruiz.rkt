#lang racket
(require htdp/docs)
;Ejercicio1
(define (cuenta-atomos simbolo lista)
  (length (filter (lambda (x) (equal? x simbolo)) lista)))
;Ejercicio2
(define (borra-y-cuadrado lista numero)
  (map (lambda (x) (* x x)) (filter (lambda (x) (or (> numero x) (= numero x)))  lista)))
;Ejercicio3
(define (borra-grandes lista numero)
  (filter (lambda (x) (> (* x x) numero)) lista))
;Ejercicio4
(define (lista-listas l1 l2)
  (map (lambda (x y) (list x y)) l1 l2))
;Ejercicio5
(define (todo-atomos lista)
  (andmap (lambda (x) (atom? x)) lista))
;Ejercicio6
(define (mi-reduce operacion lista)
  (apply operacion lista))

;Ejercicio7
;(mi-funcion '(1 2 3 4 5 8 0 0 -1) 'a)
;(mi-funcion '(1 2 3 4 5 8 0 0 -1) 'b)
;(mi-funcion '(1 2 3 4 5 8 0 0 -1) 'c)
(define (mi-funcion lista accion)
  (cond [(equal? accion 'a) (filter (lambda (x) (and (> x 1) (< x 5))) lista)]
  [(equal? accion 'b) (length (filter (lambda (x) (= 0 x)) lista))]
  [(equal? accion 'c) (length (filter (lambda (x) (negative? x)) lista))]))
