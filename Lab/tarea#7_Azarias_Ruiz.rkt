#lang racket

;(filtrar 'a '(1 2 3 5 4 a 6 b))
;(1 2 3 5 4 6 b)
(define (filtrar letra lista) 
  (cond[(empty? lista) null]
       [(equal? letra (car lista)) (filtrar letra (cdr lista))]
       [else (cons (car lista) (filtrar letra (cdr lista)))]))

;(multiplo 3 '(6 2 3 4 5 a))
;(6 3)
(define (multiplo numero lista)
  (cond[(empty? lista) null]
       [(not(number? (car lista))) (multiplo numero (cdr lista))]
       [(equal? 0 (modulo (car lista) numero)) (cons (car lista) (multiplo numero (cdr lista)))]))

;(existe 'a '(1 2 3 5))
;#f
;(existe 'a '(1 2 3 a)
;#t
(define (existe letra lista)
  (cond [(empty? lista) #f]
        [(equal? letra (car lista)) #t]
        [else (existe letra (cdr lista))]))


;(encontrar 5 '(1 2 4 5))
;5
;(encontrar 5 '(1 2 4)
;null
(define (encontrar numero lista)
  (cond [(empty? lista) null]
        [(equal? numero (car lista)) (car lista)]
        [else (encontrar numero (cdr lista))]))

;(ultimo '(1 2 3 4))
;4
(define (ultimo lista) 
  (cond [(empty? lista) empty]
        [(equal? (length lista) 4) (car lista)]
        [else (ultimo(cdr lista))]))

