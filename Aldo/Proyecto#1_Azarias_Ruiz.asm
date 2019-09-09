;Agenda.asm: guardar contactos en memoria. 
;Author: Azarias Ruiz
;Date: Agosto - Septiembre 2019
.model small
.stack 100h
    CR equ 13d
    LF equ 10d
    
    DOC      equ 0d
    NOMBRE   equ 20d
    APELLIDO equ 40d
    TELEFONO equ 60d
    CORREO   equ 80d
    TAM      equ 100

.data
    propietario_msg db "Ingrese el propietario de la agenda: ", "$"
    salir_msg       db CR, LF, "Seguro que desea salir? s/n: ", "$"
    cantidad_msg    db CR, LF, "Ingrese la cantidad de contactos: ", "$"
    agenda_msg      db CR, LF, "Agenda: ", "$"
    total_msg       db CR, LF, "Total de contactos: ", "$"
    disponibles_msg db CR, LF, "Registros disponibles: ", "$"
    documento_msg   db CR, LF, "Numero de documento: ", "$"
    nombre_msg      db CR, LF, "Nombre: ", "$"
    apellido_msg    db CR, LF, "Apellido: ", "$"
    telefono_msg    db CR, LF, "Telefono: ", "$"
    correo_msg      db CR, LF, "Correo: ", "$"
    enter           db CR, LF, "$"
    cabecera        db CR, LF, "#",9d,"Doc.",9d,"Nombre",9d,"Apellido",9d,"Tel.",9d,"Correo",CR,LF,"$"
    menu            db CR, LF, "Opciones:", CR, LF, "1. Agregar Contacto", CR, LF, "2. Buscar Contacto", CR, LF, "3. Modificar Contacto", CR, LF, "4. Borrar Contacto", CR, LF, "5. Salir de la agenda", CR, LF, "Selecione una opcion: ","$"
    no_existe       db CR, LF, "No se encontro el contacto", "$"
    eliminar_msg    db CR, LF, "Desea eliminar el contacto? s/n: ", "$"
    eliminado_msg   db CR, LF, "Contacto eliminado...", "$"
    sin_espacio     db CR, LF, "Espacio insuficiente. Ya no puede agregar contactos", "$"
    corto           db CR, LF, "Muy corto, minimo de 6 digitos ", "$"
    tel_corto       db CR, LF, "Muy corto, minimo de 7 digitos ", "$"
    doc_registrado  db CR, LF, "Ya se registro ese documento...", "$"
    edit_menu       db CR, LF, "Editar:", CR, LF, "1. Nombre",CR, LF, "2. Apellido", CR, LF, "3. Telefono", CR, LF, "4. Correo", CR, LF, "5. Volver atras", CR, LF, "$"
    editado_msg     db CR, LF, "Contacto editado...", "$"
    agenda          db 500 dup('$')
    propietario     db 15 dup('$')
    documento       db 10 dup ('$')
    
    cantidad        db ?            ;cantidad de contactos ingresada por el usuario
    disponibles     db ?            ;contactos disponibles
    opcion          db ?            ;entrada del usuario
    nro_contacto    db 0            ;contador para la cantidad de contactos
    i               db 0                                                                                                                          
    j               dw 0
    long            db 0
    
.code
start:
    mov ax, @data
    mov ds, ax
    call solicitar_propietario
    mov DI, 0
    
    call guardar_propietario
    call solicitar_cantidad
    call guardar_cantidad
    resumen:
        call limpiar_pantalla
        call imprimir_grilla
        
    obtener_campo:
        call getc
        mov agenda[DI], al
        inc DI
        inc long
        cmp al, 13d
        jne obtener_campo
        ret
        
    obtener_documento3:
        call getc
        mov documento[SI], al
        inc SI
        inc long
        cmp al, 13d
        jne obtener_documento3
        ret
    
    agregar_contacto:
        call limpiar_pantalla   
        ;mov i, 0d
        mov dh, nro_contacto
        ;mov ah, 0d                      ;limpia el registro para la multiplicacion
        ;mov al, TAM
        ;mov bl, nro_contacto
        ;mul bl                          ;al= resultado de la multiplicacion
        ;mov ah, 0d                      ;limpia el registro para asignar a DI
        ;mov DI, ax                      ;DI = resultado de la multlicacion 
        mov DI, 0d
        mov j, DI
        mov cx, DI
        evaluar:
            cmp dh, cantidad
            jge insuficiente_espacio
            cmp agenda[DI], '$'
            je cargar_datos
            jne siguiente_posicion
            siguiente_posicion:
                add DI, TAM 
                mov j, DI
                ;add cx, TAM
                ;inc dh
                jmp evaluar
                
   insuficiente_espacio:
        mov ax, offset sin_espacio
        call puts
        call pausar
        jmp resumen
        
   telefono_corto:
        mov ax, offset tel_corto
        call puts
        ;call pausar
        jmp solicitar_telefono
        
   doc_corto:
        mov ax, offset corto
        call puts
        jmp solicitar_doc
        
   doc_existente:
        mov ax, offset doc_registrado
        call puts
        jmp cargar_datos 
   
   cargar_datos:
        mov bx, j                      ;bx = copia de DI
        mov cx, j                      ;cx = copia de DI
        solicitar_doc:
            mov long, 0d
            mov DI, cx
            mov ax, offset documento_msg
            call puts
            mov SI, 0
            call obtener_documento3
            ;dec DI
            dec long
            ;mov agenda[DI], '$'
            dec SI
            mov documento[SI], '$'
            cmp long, 6d
            jl doc_corto
            cmp long, 0d
            je solicitar_doc             ;vuelve a solicitar
            mov cl, 0d
            mov DI, 0d
            mov SI, 0d
            cmp_uniqueness:
                mov bh, 0d                      ;limpio registro
                mov ah, 0d                      ;limpia el registro para la multiplicacion
                mov al, TAM                     
                mov bl, cl
                mul bl
                mov ah, 0d
                mov DI, ax
                mov bl, al
                comparar2:
                    mov bh, documento[SI] 
                    cmp agenda[DI], bh
                    jne saltar_siguiente2
                    cmp agenda[DI], '$'
                    je doc_existente 
                    cmp agenda[DI], bh
                    je incrementar2
                    incrementar2:
                        inc DI
                        inc SI
                        jmp comparar2         
                ret
            
                saltar_siguiente2:       ;salta a la posicion del documento del siguiente contacto
                    inc cl
                    cmp cl, cantidad
                    jge guardar_resto 
                    add DI, TAM        ;salta al siguiente numero de documento
                    add bx, TAM
                    mov SI, 0           ;reseteo el contador de la variable documento
                    jmp comparar2     
        guardar_resto:
            mov cx, j
            mov bx, j
            mov DI, cx
            mov SI, 0
            copiar_documento:
                mov cl, documento[SI]
                mov agenda[DI], cl
                inc SI
                inc DI
                cmp documento[SI], '$'
                jne copiar_documento
                
        mov agenda[DI], '$'    
        mov cx, j
        mov bx, j
        ;guarda el nombre
        solicitar_nombre:
            mov DI, cx
            add DI, NOMBRE
            mov bx, DI
            mov ax, offset nombre_msg
            call puts
            call obtener_campo
            dec DI
            mov agenda[DI], '$'
            cmp bx, DI
            je solicitar_nombre 
        
        ;guarda el apellido
        solicitar_apellido:
            mov DI, cx
            add DI, APELLIDO
            mov bx, DI
            mov ax, offset apellido_msg
            call puts
            call obtener_campo
            dec DI
            mov agenda[DI], '$'
            cmp bx, DI
            je solicitar_apellido
        
        ;guarda el telefono
        
        solicitar_telefono:
            mov long, 0d
            mov DI, cx
            add DI, TELEFONO
            mov bx, DI
            mov ax, offset telefono_msg
            call puts
            mov long, 0d
            call obtener_campo
            dec DI
            dec long
            mov agenda[DI], '$'
            cmp long, 7d
            jl telefono_corto
            cmp bx, DI
            je solicitar_telefono
        
        ;guarda el correo 
        solicitar_correo:
            mov DI, cx
            add DI, CORREO
            mov bx, DI
            mov ax, offset correo_msg
            call puts
            call obtener_campo
            dec DI
            mov agenda[DI], '$'
            cmp bx, DI
            je solicitar_correo
        
        inc nro_contacto
        dec disponibles
        jmp resumen
        
    buscar_contacto:
        call limpiar_pantalla
        mov ax, offset documento_msg
        call puts
        mov bh, 0           ;limpio registro
        mov DI, 0           ;contador para arreglo agenda
        mov cl, 0           ;contador para la cantidad de contactos
        mov SI, 0           ;contador para variable documento
        obtener_documento2:
            call getc
            mov documento[DI], al
            inc DI
            cmp al, 13d
            jne obtener_documento2
        dec DI
        mov documento[DI], '$'
        mov bh, 0d                      ;limpio registro
        mov ah, 0d                      ;limpia el registro para la multiplicacion
        mov al, TAM                     
        mov bl, cl
        mul bl
        mov ah, 0d
        mov DI, ax
        mov bl, al
        comparar:
            mov bh, documento[SI] 
            cmp agenda[DI], bh
            jne saltar_siguiente
            cmp agenda[DI], '$'
            je doc_encontrado 
            cmp agenda[DI], bh
            je incrementar
            incrementar:
                inc DI
                inc SI
                jmp comparar         
        ret
    
    saltar_siguiente:       ;salta a la posicion del documento del siguiente contacto
        inc cl
        cmp cl, cantidad
        jge no_encontrado 
        add DI, TAM        ;salta al siguiente numero de documento
        add bx, TAM
        mov SI, 0           ;reseteo el contador de la variable documento
        jmp comparar
        
    no_encontrado:
        mov ax, offset no_existe
        call puts
        call pausar
        jmp resumen
    
    mostrar_campo:
        mov al, offset agenda[DI]
        call putc
        inc DI
        cmp agenda[DI], '$'
        jne mostrar_campo
        ret
                 
    doc_encontrado:
        mov bh, 0d          ;limpio registro 
        ;muestra el nombre
        
        mov ax, offset nombre_msg
        call puts
        mov DI, bx
        add DI, NOMBRE
        call mostrar_campo
        ;muestra el apellido        
        mov ax, offset apellido_msg
        call puts
        mov DI, bx
        add DI, APELLIDO
        call mostrar_campo
        ; muestra el telefono    
        mov ax, offset telefono_msg
        call puts 
        mov DI, bx
        add DI, TELEFONO
        call mostrar_campo
        ;muestra el correo    
        mov ax, offset correo_msg
        call puts
        mov DI, bx
        add DI, CORREO
        call mostrar_campo
            
        cmp opcion, 4d
        je confirmar_borrado
        
        cmp opcion, 3d
        je campo_a_editar
        
        jmp resumen
        
        
    modificar_contacto:
        jmp buscar_contacto
        ret
        
    campo_a_editar:
        mov ax, offset enter
        call puts
        mov ax, offset edit_menu
        call puts
        call getc
        cmp al, '1'
        je  modificar_nombre
        cmp al, '2'
        je  modificar_apellido
        cmp al, '3'
        je  modificar_telefono
        cmp al, '4'
        je  modificar_correo
        cmp al, '5'
        je resumen
        jmp resumen
        
    modificar_nombre:
        mov bh, 0d          ;limpio registro 
        nombre:
            mov DI, bx
            add DI, NOMBRE
            mov cx, DI
            mov ax, offset nombre_msg
            call puts
            call obtener_campo
            dec DI
            mov agenda[DI], '$'
            cmp cx, DI
            je nombre
            jmp edicion_exitosa
            
    modificar_apellido:
        mov bh, 0d          ;limpio registro 
        apellido:
            mov DI, bx
            add DI, APELLIDO
            mov cx, DI
            mov ax, offset apellido_msg
            call puts
            call obtener_campo
            dec DI
            mov agenda[DI], '$'
            cmp cx, DI
            je apellido
            jmp edicion_exitosa
            
        ret
    modificar_telefono:
        mov bh, 0d          ;limpio registro 
        telefono: 
            mov long, 0d
            mov DI, bx
            add DI, TELEFONO
            mov cx, DI
            mov ax, offset telefono_msg
            call puts
            call obtener_campo
            dec DI
            mov agenda[DI], '$'
            cmp cx, DI
            je telefono
            cmp long, 7d
            jl telefono_corto
            jmp edicion_exitosa
            
    telefono_corto2:
        mov ax, offset tel_corto
        call puts
        ;call pausar
        jmp modificar_telefono
        
            
    modificar_correo:
        mov bh, 0d          ;limpio registro
        correo:
            mov DI, bx
            add DI, CORREO
            mov cx, DI
            mov ax, offset correo_msg
            call puts
            call obtener_campo
            dec DI
            mov agenda[DI], '$'
            cmp cx, DI
            je correo
            jmp edicion_exitosa
            
    edicion_exitosa:
         mov ax, offset editado_msg
         call puts
         call pausar
         jmp resumen
            
    borrar_contacto:
        jmp buscar_contacto
        
    limpiar_campo:
        mov agenda[DI], '$'
        inc DI
        cmp agenda[DI], '$'
        jne limpiar_campo
        ret
        
    confirmar_borrado:
        mov ax, offset enter
        call puts  
        mov ax, offset eliminar_msg 
        call puts
        call getc
        cmp al, 's'
        je eliminar
        cmp al,'n'
        je resumen
        ret
        
    eliminar:
        mov bh, 0d          ;limpio registro
        mov DI, bx
        call limpiar_campo
        mov DI, bx
        add DI, NOMBRE
        call limpiar_campo
        mov DI, bx
        add DI, APELLIDO
        call limpiar_campo
        mov DI, bx
        add DI, TELEFONO
        call limpiar_campo
        mov DI, bx
        add DI, CORREO
        call limpiar_campo
        dec nro_contacto
        inc disponibles
        mov ax, offset eliminado_msg
        call puts
        call pausar
        jmp resumen
        
    salir_agenda:
        mov ax, offset salir_msg
        call puts
        call getc
        cmp al, 's'
        je finish
        ret
   
    imprimir_grilla:
        mov ax, offset enter
        call puts
        mov ax, offset agenda_msg
        call puts
        mov ax, offset propietario
        call puts
        mov ax, offset total_msg
        call puts
        mov al, cantidad
        call MOSTRAR_NUM_DOS_DIGITOS 
        mov ax, offset disponibles_msg
        call puts
        mov al, disponibles
        CALL MOSTRAR_NUM_DOS_DIGITOS
        mov ax, offset cabecera
        call puts
        ;imprime las columnas de la tabla
        mov cl, 0d                      ;contador para las impresiones de cada contacto
        cmp cl, nro_contacto
        jl imprimir_contactos
        je imprimir_menu
        ret
        
    imprimir_contactos:
        mov i, 0d
        mov ch, i                       ;contador para la cantidad max
        ;calculo auxiliar
        mov bh, 0d                      ;limpia el registro
        mov ah, 0d                      ;limpia el registro para la multiplicacion
        mov al, TAM
        mov bl, cl
        mul bl
        mov DI, ax
        ;mov ch, al                     ;ch= resultado de la mult. (pos inicial de cada contacto)
        mov bl, al                      ;copia de DI
        aux:
            cmp agenda[DI], '$'
            jne imprimir_datos
            je increment
            increment:
                add DI, TAM 
                add bx, TAM
                ;inc cl
                inc ch
                mov i, ch
                cmp ch, cantidad
                jge imprimir_menu
                jmp aux   
                     
    imprimir_datos:
    
        ;imprime el numero de contacto
        mov al, cl    ;al=1
        inc al
        add al, 48d
        call putc
        mov al, 9d
        call putc
        
        ;imprime el documento
        call mostrar_campo
        mov al, 9d
        call putc
        
        ;imprime el nombre
        mov DI, bx
        add DI, NOMBRE
        call mostrar_campo
        mov al, 9d
        call putc
            
        ;imprime el apellido
        mov DI, bx
        add DI, APELLIDO
        call mostrar_campo
        mov al, 9d
        call putc
        
        ;imprime el telefono
        mov DI, bx
        add DI, TELEFONO
        call mostrar_campo
        mov al, 9d
        call putc
            
        ;imprime el correo
        mov DI, bx
        add DI, CORREO
        call mostrar_campo
            
        mov ax, offset enter
        call puts
        inc cl
        add bx, TAM
        mov DI, bx
        cmp cl, nro_contacto
        jl aux
        je imprimir_menu
        
    imprimir_menu:
        mov ax, offset menu
        call puts
        mov ax, offset enter
        call puts
        call getc
        sub al, 48d
        mov opcion, al
        cmp al, 1d
        je agregar_contacto
        cmp al, 2d
        je buscar_contacto
        cmp al, 3d
        je modificar_contacto
        cmp al, 4d
        je borrar_contacto
        cmp al, 5d
        je salir_agenda
        call finish
        ret
        
    solicitar_cantidad:
        mov ax, offset cantidad_msg
        call puts
        ret
        
    guardar_cantidad:
        call nro_dos_digitos
        mov cantidad, bh
        mov disponibles, bh
        ret
        
    solicitar_propietario:
        mov ax, offset propietario_msg
        call puts
        ret
        
    guardar_propietario:  
        call getc
        mov propietario[DI], al
        inc DI
        cmp al, 13d
        jne guardar_propietario
        ret
        
    MOSTRAR_NUM_DOS_DIGITOS:                ;subrutina proporcionada por el profesor en la clase de laboratorio
        ;Muestra un numero de dos digitos cargado AL
        AAM
        MOV BX, AX
        MOV AH, 02h
        MOV DL, BH
        ADD DL, 30h
        INT 21H
        MOV AH, 02h
        MOV DL, BL
        ADD DL, 30H
        INT 21H
        ret
        
    nro_dos_digitos:     ;carga un numero de dos digitos en bh
        call geti
        mov bl, 10
        mul bl
        mov bh, al
        call geti
        add bh, al
        ret
        
    geti:               ;carga un decimal en al
        call getc
        sub al, 48d
        ret
        
     pausar:                          ;pausa la ejecucion del programa un segundo
        push ax ; save ax
        push bx ; save bx
        push cx ; save cx
        push dx ; save dx
        mov cx,0fh                  
        mov dx,4240h
        mov ah,86h
        int 15h
        pop dx ; restore dx
        pop cx ; restore cx
        pop bx ; restore bx
        pop ax ; restore ax
        ret 
        
    limpiar_pantalla:         ;limpia la pantalla del MS-DOS
        push ax ; save ax
        push bx ; save bx
        push cx ; save cx
        push dx ; save dx
        mov ah,00h
        mov al,03h       
        int 10h
        pop dx ; restore dx
        pop cx ; restore cx
        pop bx ; restore bx
        pop ax ; restore ax    
        ret
        
    finish:
        mov ax, 4c00h
        int 21h 
        
    ; user defined subprograms
    puts: ; display a string terminated by $
        ; dx contains address of string
        push ax ; save ax
        push bx ; save bx
        push cx ; save cx
        push dx ; save dx
        mov dx, ax
        mov ah, 9h
        int 21h ; call ms-dos to output string
        pop dx ; restore dx
        pop cx ; restore cx
        pop bx ; restore bx
        pop ax ; restore ax
        ret

    putc: ; display character in al
        push ax ; save ax
        push bx ; save bx
        push cx ; save cx
        push dx ; save dx
        mov dl, al
        mov ah, 2h
        int 21h
        pop dx ; restore dx
        pop cx ; restore cx
        pop bx ; restore bx
        pop ax ; restore ax
        ret

    getc: ; read character into al
        push bx ; save bx
        push cx ; save cx
        push dx ; save dx
        mov ah, 1h
        int 21h
        pop dx ; restore dx
        pop cx ; restore cx
        pop bx ; restore bx
        ret
        
end start