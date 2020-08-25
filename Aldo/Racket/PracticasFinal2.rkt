#lang racket
(require racket/trace)

; funciones aplicativas
; map: Applies proc to the elements of the lsts from the first elements to the last.
; (map proc lst ...+) → list?

; andmap: the result is #f if any application of proc produces #f, in which case proc is not applied to later elements of the lsts.
; the result is that of proc applied to the last elements of the lsts
; (andmap proc lst ...+) → any

; ormap: the result is #f if every application of proc produces #f.
; the result is #f if every application of proc produces #f
; (ormap proc lst ...+) → any

; foldl: applies a procedure to the elements of one or more lists.
; Whereas map combines the return values into a list, foldl combines the return values in an arbitrary way that is determined by proc.
; The input lsts are traversed from left to right, and the result of the whole foldl application is the result of the last application of proc.
; If the lsts are empty, the result is init.
;(foldl proc init lst ...+) → any/c

; foldr: Like foldl, but the lists are traversed from right to left. Unlike foldl, foldr processes the lsts in space proportional to the length of lsts 
; (plus the space for each call to proc).
; (foldr proc init lst ...+) → any/c

; filter: Returns a list with the elements of lst for which pred produces a true value. The pred procedure is applied to each element from first to last.
; (filter pred lst) → list?

; remove; Returns a list that is like lst, omitting the first element of lst that is equal to v using the comparison procedure proc (which must accept two arguments).
; (remove v lst [proc]) → list?

;remove*: Like remove, but removes from lst every instance of every element of v-lst.
;(remove* v-lst lst [proc]) → list?

(define (invertir lista)
  (foldl cons '() lista))

(define (mayor lista)
         (foldl max 0 (filter number? (flatten lista))))

(define (suma-cuadrados lista)
  (foldr + 0 (map (lambda (x) (* x x)) lista)))

(define (lista-cuadrados lista)
  (map (lambda (x) (* x x)) lista))

(define (get-numeros lista)
  (filter number? lista))

(define (get-simbolos lista)
  (filter symbol? lista))

(define (cuenta-atomos atomo lista)
  (foldr + 0 (map (lambda (x) (if (equal? x atomo) 1 0) ) lista)))

(define (borra-y-cuadrado lista numero)
  (map (lambda (x) (* x x)) (filter (lambda (x) (or (< x numero) (= x numero))) lista)))

(define (borra-grandes lista numero)
  (filter (lambda (x) (> (* x x) numero)) lista))

(define (lista-listas lista1 lista2)
  (map (lambda (x y) (cons x (cons y null))) lista1 lista2))