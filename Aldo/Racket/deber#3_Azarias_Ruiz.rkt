#lang racket
(require racket/trace)
;Ejercicio1
(define (quitar_de_lista palabra lista)
  (remove* (list palabra) lista))

;Ejercicio2
(define (buscar-mayor lista)
         (foldl max 0 (filter number? (flatten lista))))

;Ejercicio3
(define (rotar sentido lista)
  (define (iterar-izq sublista)
  (map (lambda (x) (cond[(list? x) (append (cdr x) (list (car x)))]
                        [else x])) sublista))
  (define (iterar-der sublista)
  (map (lambda (x) (cond[(list? x) (append (list(car (foldl cons '() x))) (remove (list-ref x (- (length x) 1)) x))]
                        [else x])) sublista))
  (cond[(equal? sentido 'izquierda) (append (cdr (iterar-izq lista)) (list (car lista)))]
       [(equal? sentido 'derecha) (append (list(car (foldl cons '() lista))) (remove (list-ref lista (- (length lista) 1)) (iterar-der lista)))]))

;Ejercicio4
(define (censurar palabra reemplazo lista)
  
  (define (censurar-aux1 palabra reemplazo sublista)
    (map (lambda (x) (cond[(equal? x  palabra) reemplazo]
                                        [(list? x) (censurar-aux2 palabra reemplazo x)]
                                        [else x])) sublista))
  (define (censurar-aux2 palabra reemplazo sublista)
    (map (lambda (x) (cond[(equal? x  palabra) reemplazo]
                                        [else x])) sublista))
  (map (lambda (x) (cond[(equal? x  palabra) reemplazo]
                                        [(list? x) (censurar-aux1 palabra reemplazo x)]
                                        [else x])) lista))

;Ejercicio5
(define (get-numeros lista)
  (filter number? (flatten lista)))

;Ejercicio6
(define (MIEMBRO elemento lista)
   (cond[(= 0 (foldl + 0 (map (lambda(x)(if(equal? x elemento) 1 0))lista))) 'NIL]
        [else 'T]))

;Ejercicio7
(define (ELIMINAR-PARES lista)
  (define (eliminar-pares-aux1 sublista)
    (filter (lambda (x) (or (or (list? x) (number? x)) (symbol? x))) (map (lambda (x) (cond[(and (number? x) (odd? x)) x]
                                                                                           [(list? x) (eliminar-pares-aux2 x)]
                                                                                           [(symbol? x) x])) sublista)))
  (define (eliminar-pares-aux2 sublista)
    (filter (lambda (x) (or (or (list? x) (number? x)) (symbol? x))) (map (lambda (x) (cond[(and (number? x) (odd? x)) x]
                                                                                           [(symbol? x) x])) sublista)))
  (filter (lambda (x) (or (or (list? x) (number? x)) (symbol? x))) (map (lambda (x) (cond[(list? x) (eliminar-pares-aux1 x)]
                                                                                         [(and (number? x) (odd? x)) x]
                                                                                         [(symbol? x) x])) lista)))

;Ejercicio8
(define (CONTAR-PARES lista)
  (length (filter (lambda (x) (and (number? x) (even? x))) (flatten lista))))

;Ejercicio9
(define (suma-de-cuadrado lista)
  (foldl + 0 (map (lambda(x)(* x x)) lista)))

;Ejercicio10
(define (mi-reduce operacion lista)
  (cond [(equal? operacion +) (foldl operacion 0 (flatten lista))]
        [(equal? operacion -) (foldr operacion (car (flatten lista)) (cdr(flatten lista)))]
        [(equal? operacion *) (foldl operacion 1 (flatten lista))]))


