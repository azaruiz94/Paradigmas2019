#lang racket
(require racket/trace)
;Ejercicio 1
;(define lista (list (5 6) 1 2 3 4 5))
;(listacuadrados '(1 4 a 6 10 (4 5)))
;((1 1) (4 16) (6 36) (10 100) ((4 16) (5 25)))
(define (listacuadrados lista)
  (cond[(empty? lista) null]
       [(list? (car lista)) (cons (listacuadrados (car lista)) (listacuadrados (cdr lista)))]
       [(not (number? (car lista))) (listacuadrados (cdr lista))]
       [else (cons (list (car lista) (* (car lista) (car lista))) (listacuadrados (cdr lista)))]))
;Ejercicio 2
;Escribe una función TODOS-IGUALES, que, dada una lista de átomos cualesquiera, devuelva #t si todos ellos son iguales y #f si alguno difiere.
;(todos-iguales '(A A A A A A A A))
;#t
;(todos-iguales '(A A A B A))
;#f
;(todos-iguales '(A A A A A A (A A)))
;#t
;(todos-iguales '(A A A A A A A A (A C)))
;#f
(define (todos-iguales lista)
   (cond [(null? lista) #t]
     [(empty? (cdr lista)) #t]
     [(list? (car (cdr lista))) (and (todos-iguales (car(cdr lista))) (todos-iguales (cdr lista)))]
     [(equal? (car lista) (car(cdr lista))) (todos-iguales(cdr lista))]
     [else #f]))

;Ejercicio 3
;Haz una función que devuelva la profundidad máxima de paréntesis anidados en una lista. Por ejemplo:
;(max-parentesis '((A B C D)))
;2
;(max-parentesis '((A . B) (C . D)))
;2
;(max-parentesis '(A B C))
;1
;(max-parentesis '((A . B) (C (D (X)))))
;4
(define (max-parentesis lista)
  (cond [(empty? lista) 1]
        [(list? (car lista)) (+ 1 (max-parentesis (car lista)))]
        [(cons? (cdr lista)) (max-parentesis (cdr lista))]
        [(cons? (car lista)) (+ 1 (max-parentesis (cdr lista)))]
        [else (max-parentesis (cdr lista))]))

;Ejercicio 4
;Haz una función que devuelva todos los elementos de un árbol en una lista de un sólo nivel.
;(aplana '((N O) ((T E) (R I A S)) (Q U E) ((E S) (P E O R))))
;(N O T E R I A S Q U E E S P E O R)
(define (aplana lista)
  (define (get-atomo-aux lista)
    (cond[(empty? lista) null]
         [(list? (car lista)) (mi-append (get-atomo-aux (car lista)) (get-atomo-aux (cdr lista)))]
         [(or (number? (car lista)) (symbol? (car lista))) (mi-append (list (car lista)) (get-atomo-aux (cdr lista)))]))
  (get-atomo-aux lista))

;Ejercicio 5
;Escribir la función contar-multiplo que recibe una lista, un número y devuelve la cantidad de números que son múltiplos que encuentra en la lista (usando recursión de cola)
;(contar-multiplo '(1 2 3 A (1 2 a 4) 4 5 x 6) 2)
;5
;(contar-multiplo '(1 a) 2)
;0
;(contar-multiplo '(A (1 2)3) 2)
;1
(define (contar-multiplo lista numero)
  (define (contar-multiplo-aux lista numero contador)
    (define (aux sublista numero contador)
      (cond [(empty? sublista) (contar-multiplo-aux (cdr lista) numero contador)]
            [(list? (car sublista)) (aux(car sublista) numero contador)]
            [(and (number? (car sublista)) (equal? (modulo (car sublista) numero) 0)) (aux (cdr sublista) numero (+ 1 contador))]
            [(not (number? sublista)) (aux (cdr sublista) numero contador)]
            ))
    (cond[(empty? lista) contador]
         [(list? (car lista)) (aux (car lista) numero contador)]
         [(not (number? (car lista))) (contar-multiplo-aux (cdr lista) numero contador)]
         [(equal? (modulo (car lista) numero) 0) (contar-multiplo-aux (cdr lista) numero (+ 1 contador))]
         [else (contar-multiplo-aux (cdr lista) numero contador)]))
  
  (contar-multiplo-aux lista numero 0))


;Ejercicio 6
;Escribir la función cuenta-pares que recibe una lista y devuelve cuantos números pares tiene (usando recursión de cola)
;(cuenta-pares '(1 2 (x (6 a)) 3 4 a))
;3
(define (cuenta-pares lista)
  (define (cuenta-pares-aux lista contador)
    (define (aux sublista contador)
      (cond[(empty? sublista) (cuenta-pares-aux (cdr lista) contador)]
           [(symbol? (car sublista)) (aux (cdr sublista) contador)]
           [(list? (car sublista)) (aux (car sublista) contador)]
           [(and (number? (car sublista)) (equal? (modulo (car sublista) 2) 0)) (aux (cdr sublista) (+ 1 contador))]))
    (cond[(empty? lista) contador]
         [(list? (car lista)) (aux (car lista) contador)]
         [(and (number? (car lista)) (equal? (modulo (car lista) 2) 0)) (cuenta-pares-aux (cdr lista) (+ 1 contador))]
         [else (cuenta-pares-aux (cdr lista) contador)]))
  (cuenta-pares-aux lista 0))

;Ejercicio 7
;Escribir la función get-posicion que determina la posición de un símbolo en la lista (usando recursión de cola), comienza a contar en uno (1)
;(get-posicion 'c '(a b c d))
;3
;(get-posicion 'c '(a (1 2) b c d))
;4
;(get-posicion 'c '(a b (4 c) d))
;3
(define (get-posicion symbol lista)
  (define (posicion-aux simbolo lista contador)
    (define (aux simbolo sublista contador)
      (cond[(empty? sublista) (posicion-aux simbolo (cdr lista)(+ 1 contador))]
           [(equal? (car sublista) simbolo) contador]
           [else (aux simbolo (cdr sublista) contador)]))
    (cond[(empty? lista) 0]
         [(equal? (car lista) simbolo) contador]
         [(list? (car lista)) (aux simbolo (car lista) contador)]
         [else (posicion-aux simbolo (cdr lista) (+ 1 contador))]))
  (posicion-aux symbol lista 1))

;Ejercicio 8
;Escribir la función get-numeros que extrae todos los números que aparecen en una lista
;(get-numeros '((1 (2)) a (((5 c 7))) 4))
;(1 2 5 7 4)
;(get-numeros '((1 2) a (5 c 7) 4))
;(1 2 5 7 4)
(define (get-numeros lista)
  (define (get-numeros-aux lista resultado)
    (define (aux sublista resultado)
      (cond[(empty? sublista) (get-numeros-aux (cdr lista) resultado)]
           [(list? (car sublista)) (aux (car sublista) resultado)]
           [(symbol? (car sublista)) (aux (cdr sublista) resultado)]
           [(number? (car sublista)) (aux (cdr sublista) (mi-append resultado (list(car sublista))))]))
    (cond[(empty? lista) resultado]
         [(list? (car lista)) (aux (car lista) resultado)]
         [(number? (car lista)) (get-numeros-aux (cdr lista) (mi-append resultado (list(car lista))))]
         [else (get-numeros-aux (cdr lista) resultado)]))
  (get-numeros-aux lista '()))

;Ejercicio 9
;Escriba la función BUSCAR-MAYOR que dado una lista encuentra el valor más alto. (usando recursión de cola)
;(buscar-mayor  '(1 3  4 23 9 20))
;23
;(buscar-mayor  '(1 3 (a 5 (5 90))  4 23 9 20))
;90
(define (buscar-mayor lista)
  (define (buscar-mayor-aux lista mayor)
    (define (aux sublista mayor)
      (cond[(empty? sublista) (buscar-mayor-aux (cdr lista) mayor)]
           [(list? (car sublista)) (aux (car sublista) mayor)]
           [(symbol? (car sublista)) (aux (cdr sublista) mayor)]
           [(and (number? (car sublista)) (> (car sublista) mayor)) (aux (cdr sublista) (car sublista))]
           [else (aux (cdr sublista) mayor)]))
    (cond[(empty? lista) mayor]
         [(list? (car lista)) (aux (car lista) mayor)]
         [(and (number? (car lista)) (> (car lista) mayor)) (buscar-mayor-aux (cdr lista) (car lista))]
         [else (buscar-mayor-aux (cdr lista) mayor)]))
  (buscar-mayor-aux lista 0))

;Ejercicio 10
;Escriba la función ALTERNAR que crea una lista de orden alternado a los elementos de las 2 listas pasadas, los elementos de la segunda lista deben aparecer en una lista
;(alternar '(1 2 3 4 5) '( 7 8 9))
;(1 (7) 2 (8) 3 (9) 4 5) ; alternar hasta donde existan elementos!!!
;(alternar '(1 2 3 4 5) '( 7 8 (9)))
;(1 (7) 2 (8) 3 (9) 4 5) ; si es una lista no genera una lista de lista
(define (alternar lista1 lista2)
  (define (alternar-aux lista1 lista2)
    (cond[(empty? lista1) null]
         [(empty? lista2) (cons (car lista1) (alternar-aux (cdr lista1) '()))]
         [else (mi-append (cons (car lista1) (list (cons (car lista2) null))) (alternar-aux (cdr lista1) (cdr lista2)))]))
  (alternar-aux (aplana lista1) (aplana lista2)))

;Ejercicio 11
;Escribir la función resta-listas que devuelve una lista con los elementos de la primera lista que no aparecen en la segunda
;(resta-listas '(1 2 3 4) '(2 3))
;(1 4)
(define (resta-listas lista1 lista2)
  (define (buscar elemento lista)
    (cond[(empty? lista) #f]
         [(equal? elemento (car lista)) #t]
         [else (buscar elemento (cdr lista))]))
  (cond[(empty? lista1) null]
       [(not(buscar (car lista1) lista2)) (cons (car lista1) (resta-listas (cdr lista1) lista2))]
       [else (resta-listas (cdr lista1) lista2)]))

;Ejercicio 12
;Escribir la función suma-listas que devuelve una lista con los elementos de la primera lista y los de la segunda que no aparecen en la primera
;(suma-listas '(1 2 3 4) '(2 3 5))
;(1 2 3 4 5)
(define (suma-listas lista1 lista2)
  (define (buscar elemento lista)
    (cond[(empty? lista) #f]
         [(equal? elemento (car lista)) #t]
         [else (buscar elemento (cdr lista))]))
  (cond[(empty? (cdr lista1)) (mi-append lista1 (cons (car lista2) null))]
       [(buscar (car lista1) lista2) (cons (car lista1) (suma-listas (cdr lista1) (cdr lista2)))]
       [(not (buscar (car lista1) lista2)) (cons (car lista1) (suma-listas (cdr lista1) lista2))]
       [else (cons (car lista1) (suma-listas (cdr lista1) lista2))]))

;Ejercicio 13
;Escribe una función SUMATORIO, que sume todos los números entre dos dados, inclusive. (usando recursión de cola)
;(sumatorio 2 7)
;27
(define (sumatorio numero1 numero2)
  (define (sumatorio-aux numero1 numero2 suma contador)
    (cond[(> contador numero2) suma]
         [else (sumatorio-aux numero1 numero2 (+ suma contador) (+ contador 1))]))
  (sumatorio-aux numero1 numero2 0 numero1))

;Ejercicio 14
;Escriba una función que calcula la sumatoria de los elementos de una lista, esta función recibe una lista de profundidad N como parámetro. La función debe calcular la sumatoria de todas las profundidades encontradas
;(sumatoria  '(a 1 2 f (a (3 ( 4)) 5.5 (2 2( 3 a 4)) ) 4 5.4 ) )
;35.9
(define (sumatoria lista)
  (define (sumatoria-aux lista suma)
    (cond[(empty? lista) suma]
         [(number? (car lista)) (sumatoria-aux (cdr lista) (+ suma (car lista)))]
         [else (sumatoria-aux (cdr lista) suma)]))
  (sumatoria-aux (aplana lista) 0))

;Ejercicio 15
;Escriba una función que separa los elementos de una lista de acuerdo al tipo. si la lista contiene sublistas, esta también debe estar clasificada. Debe tener en cuenta listas de profundidad N
;(clasificar '(a e r 3 2 f r (g l 4 i)h e r))
;((a e r f r h e r) (3 2)((g l i) (4)))
(define (clasificar lista)
  (define (clasificar-aux lista letras numeros resultado)
    (define (aux sublista subletras subnumeros)
      (cond[(empty? sublista) (list subletras subnumeros)]
           [(symbol? (car sublista)) (aux (cdr sublista) (mi-append subletras (list (car sublista))) subnumeros)]
           [(number? (car sublista)) (aux (cdr sublista) subletras (mi-append subnumeros (list (car sublista))))]))
  (cond[(empty? lista) (append resultado (list letras numeros))]
       [(symbol? (car lista)) (clasificar-aux (cdr lista) (mi-append letras (list (car lista))) numeros resultado)]
       [(number? (car lista)) (clasificar-aux (cdr lista) letras (mi-append numeros (list (car lista))) resultado)]
       [(list? (car lista)) (mi-append (clasificar-aux (cdr lista) letras numeros resultado) (list (aux (car lista) '() '())) )]))
  (clasificar-aux lista '() '() '()))


;Ejercicio 16
;Elabora una función similar a MEMBER, que busque recursivamente un átomo en cualquier lista anidada dentro de una lista. 
;(mi-member 'x '(sqrt (/ (+ (expt x 2) (expt y 2)) 2)))
;#t
(define (mi-member simbolo lista)
  (define (mi-member-aux simbolo lista)
    (cond[(empty? lista) #f]
         [(equal? (car lista) simbolo) #t]
         [else (mi-member-aux simbolo (cdr lista))]))
  (mi-member-aux simbolo (aplana lista)))

;Ejercicio 17
;Define una función con 3 argumentos, donde el primer argumento es una lista y los siguientes son dos índices de la lista, que borre los elementos situados entre los dos exclusive. 
;(borrar '(a b c d e f) 2 5) ;borra entre tercero y cuarto
;(a b e f)
;(borrar '(a b c d e f) 4 2) ;no borra nada
;(a b c d e f)
;(borrar '(a b c d e f) 0 25) ;borra toda la lista
;NIL
(define (borrar lista indice1 indice2)
  (define (borrar-aux lista indice1 indice2 contador)
    (cond[(> indice1 indice2) lista]
         [(empty? lista) null]
         [(not (and (> contador indice1) (< contador indice2))) (cons (car lista) (borrar-aux (cdr lista) indice1 indice2 (+ 1 contador)))]
         [else (borrar-aux (cdr lista) indice1 indice2 (+ 1 contador))]))
  (borrar-aux lista indice1 indice2 1))

;Ejercicio 18
;Define una función que determine si una lista es palíndroma o no.
;(palindromo '(a b c b a))
;T
;(palindromo '(a b c c b a))
;T
;(palindromo '(a b c c c a))
;NIL
(define (palindromo lista)
  (define (invertir lista)
      (define (invertir-aux lista linvertida)
        (cond[(null? lista) linvertida]
             [else (invertir-aux (cdr lista) (cons (car lista) linvertida))] ))
      (invertir-aux lista null))
  (define (palindromo-aux lista linvertida)
    (cond [(and (empty? lista) (empty? linvertida)) 'T]
          [(equal? (car lista) (car linvertida)) (palindromo-aux (cdr lista) (cdr linvertida))]
          [else 'NIL]))
  (palindromo-aux lista (invertir lista)))

;Ejercicio 19
;Escribir la función rotar que rota los elementos de una lista hacia la derecha o hacia la izquierda 
;(rotar 'derecha '(1 2 3 4)) 
;(4 1 2 3) 
;(rotar 'izquierda '(1 2 3 4)) 
;(2 3 4 1)
(define (rotar direccion lista)
  (define (rotar-aux direccion lista resultado)
    (cond[(empty? (cdr lista)) (cons (car lista) resultado)]
         [(equal? direccion 'derecha) (rotar-aux direccion (cdr lista) (mi-append resultado (list(car lista))))]))
  (cond[(empty? lista) null]
       [(equal? direccion 'derecha) (rotar-aux direccion lista '()) ]
       [(equal? direccion 'izquierda) (mi-append (cdr lista) (list(car lista)))]))

;Ejercicio 20
;Implementar la función mi-reduce utilizando que recibe una lista y un símbolo y aplica la operación sobre la lista
;(mi-reduce '+ '(1 2 3))
;6
(define (mi-reduce operacion lista)
  (define (mi-reduce-aux operacion lista resultado)
    (cond[(empty? lista) resultado]
       [(and(equal? operacion '- ) (equal? resultado 0)) (mi-reduce-aux operacion (cdr lista) (car lista))]
       [(and(equal? operacion '* ) (equal? resultado 0)) (mi-reduce-aux operacion lista (+ resultado 1))]
       [(and(equal? operacion '/ ) (equal? resultado 0)) (mi-reduce-aux operacion (cdr lista) (car lista))]
       [(equal? operacion '+) (mi-reduce-aux operacion (cdr lista) (+ resultado (car lista)))]
       [(equal? operacion '-) (mi-reduce-aux operacion (cdr lista) (- resultado (car lista)))]
       [(equal? operacion '*) (mi-reduce-aux operacion (cdr lista) (* resultado (car lista)))]
       [(equal? operacion '/) (mi-reduce-aux operacion (cdr lista) (/ resultado (car lista)))]))
  (trace mi-reduce-aux)
  (mi-reduce-aux operacion lista 0))


;Funcion auxiliar con el mismo comportamiento que append de racket/base
(define (mi-append lista1 lista2)
  (cond[(empty? lista1) cons lista2]
       [else (cons (car lista1) (mi-append (cdr lista1) lista2))]))

