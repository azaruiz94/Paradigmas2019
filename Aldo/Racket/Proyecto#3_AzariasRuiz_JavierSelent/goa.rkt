#lang racket
(require racket/trace)
;; Universidad Nacional de Itapua
;; Proyecto de Generador de Oraciones Aleatorias
;; 
;; Materia: Paradigmas de la Programacion
;;
;; Alumno: Azarias Ruiz, Javier R. Selent.
;;
;; Basado en: http://www-cs-faculty.stanford.edu/~zelenski/rsg/handouts/107_hw1c.pdf



;; La funcion GOA es el punto de entrada para ejecutar el programa.
;; 
;; Ejemplo de uso:
;;        (goa 'Gramatica-No-termine-mi-proyecto-porque)
;;
;; El parametro corresponde a un nombre de una gramatica guardada en la 
;; variable global *gramaticas*
;;
;;
(define (goa nombre-de-gramatica) 
   (imprimir (iterar-gramatica nombre-de-gramatica (cdr (get-gramatica nombre-de-gramatica *gramaticas*)))))

;; Esta funcion tal vez te sea util
;;
;; Ejemplo de uso:
;;
;;  (es-expandible '<inicio>)   ==> T
;;
;;  (es-expandible 'palabra)    ==> nil
;;
;; Esta funcion nos sirve para distinguir entre simbolos
;; que son terminales o no. 
;;

(define (es-expandible simbolo)
    (if (symbol? simbolo) 
        [let* ((palabra (~a simbolo))
               (longitud (string-length palabra))
               (inicio (- longitud 1)))
          [cond ((not (equal? "<" (substring palabra 0 1))) #f)
                ((not (equal? ">" (substring palabra inicio longitud))) #f)
                (else #t)]]
        #f))

;; Incluye mas funciones tuyas segun tu necesidad

(define (get-gramatica nombre lista)
  (cond[(empty? lista) 'NIL]
       [(equal? nombre (caar lista)) (car lista)]
       [else (get-gramatica nombre (cdr lista))]))

(define (iterar-gramatica nombre-gramatica gramatica)
  (define (expandir expandible)
    (define (expandir-aux expandible lista-expandibles expansion)
      (cond[(empty? lista-expandibles) expansion]
           [(equal? expandible (caar lista-expandibles)) (append expansion (list-ref (cdar lista-expandibles) (random (length (cdar lista-expandibles)))))]
           [else (expandir-aux expandible (cdr lista-expandibles) expansion)]))
    (expandir-aux expandible (obtener-expandibles nombre-gramatica) '()))
  
  (cond[(empty? gramatica) null]
       [(list? (car gramatica)) (iterar-gramatica nombre-gramatica (car gramatica))]
       [(equal? (car gramatica) '<inicio>) (iterar-gramatica nombre-gramatica (expandir (car gramatica)))]
       [(es-expandible (car gramatica)) (append (iterar-gramatica nombre-gramatica (expandir (car gramatica))) (iterar-gramatica nombre-gramatica (cdr gramatica)))]
       [else (append (list (car gramatica)) (iterar-gramatica nombre-gramatica (cdr gramatica)))]))

(define (obtener-expandibles nombre-gramatica)
  (cdr (get-gramatica nombre-gramatica *gramaticas*)))

(define (imprimir frase)
  (cond[(empty? frase) (display #\space)]
       [(equal? (cadr frase)  '#\.) (display (car frase)) (display #\.)]
       [(equal? (cadr frase)  '#\,) (display (car frase)) (imprimir (cdr frase))]
       [else (display (car frase)) (display #\space) (imprimir (cdr frase))]))

;; Definicion de gramaticas
;; 
;; Es importante que tus nuevas gramaticas sigan el mismo formato que las
;; incluidas aqui
;;
(define *gramaticas* '(

   ;; Gramatica para generar poemas
   ;;
   (Gramatica-para-poemas
       (<inicio>
              (Las <objeto> <verbo> esta noche #\. ))

       (<objeto>
              (olas)
              (flores amarillas grandes)
              (sanguijuelas))

       (<verbo>
              (suspiran <adverbio>)
              (presagian como <objeto>)
              (mueren <adverbio>))

       (<adverbio>
              (cautelosamente)
              (cascarrabiosamente)))

 ;; Gramatica para generar excusas para pedir prorrogas para tu proyecto
 ;;
 (Gramatica-No-termine-mi-proyecto-porque

   (<inicio>
      (Necesito una prórroga porque <suplica> #\.))

   (<suplica>
      (<excusa-dudosa>)
      (<excusa-dudosa>)
      (<excusa-dudosa>)
      (<excusa-dudosa>)
      (<excusa-dudosa>)
      (<excusa-dudosa> #\, y luego <suplica> )
      (<excusa-dudosa> #\, y encima de eso <suplica> )
      (<excusa-dudosa> #\, y como si eso no fuera suficiente <suplica> )
      (<excusa-dudosa> #\, y escucha esto #\, <suplica> )
      (<excusa-dudosa> #\, y justo entonces <suplica> )
      (<excusa-dudosa> #\, y #\, bueno estoy un poco avergonzado por esto #\, pero <suplica> )
      (<excusa-dudosa> #\, y estoy seguro que has escuchado esto antes #\, pero <suplica> )
      (<excusa-dudosa> #\, o #\, y luego <suplica> )
      (<excusa-dudosa> #\, y si recuerdo correctamente <suplica> ))


   (<excusa-dudosa>
      (mi disco duro se borro)
      (el perro comió mi <algo>)
      (la persona con la que vivo comió mi <algo>)
      (no sabía que yo estaba en esta materia)
      (pensé que ya me había graduado)
      (mi casa se quemó)
      (pasé todo el fin de semana con una resaca) 
      (tuve <mucho-trabajo>)
      (tuve <mucho-trabajo>)
      (bueno #\, ya no recuerdo mucho de lo que pasó)
      (tuve que irme a <evento-atletico>)
      (tuve que practicar para <evento-atletico>)
      (tuve que preocuparme de <evento-atletico>)
      (perdí plata apostando en <evento-atletico>)
      (me olvidé de cómo escribir)
      (todos mis lápices se rompieron)
      (la librería ya no tenía borradores)
      (se me terminó todo mi papel)
      (tuve que irme a un evento muy importante)
      (me quedé atrapado en una tormenta)
      (mi karma no estaba bueno)
      (no tenía ganas de trabajar)
      (estaba demasiado lindo afuera)
      (el lenguaje de programación no era suficientemente abstracto)
      (tuve que lavar mi ropa)
      (perdí mi <algo>)
      (mi <algo> tuve un problema privado)
      (mi <algo> fue confiscado por aduana)
      (mi <algo> fue envuelto en una bruma misteriosa por tres dias y luego desapareció)
      (tuve sueños recurrentes sobre <algo>))

   (<mucho-trabajo>
      (<numero-impresionante> parciales)
      (<numero-impresionante> parciales y <numero-impresionante> tareas)
      (que terminar mi propuesta de tesis)
      (<numero-impresionante> programas en <numero-impresionante> lenguajes distintos))

   (<evento-atletico>
      (las unimpiadas)
      (una lucha libre de yacares)
      (un partido de futbol)
      (las semi-finales de danza paraguaya))

   (<numero-impresionante>
      (4)
      (7)
      (como #\, un millón de)
      (toneladas de)
      (mega)
      (como #\, muchisimos #\,))

   (<algo>
      (disco duro)
      (cd)
      (mochila)
      (mente)
      (sentido de propósito)
      (libro)
      (anotaciones)
      (mi compu)
      (mi notebook)
      (especificacion del módulo)
      (código fuente)
      (sueños)
      (motivación)))
))




