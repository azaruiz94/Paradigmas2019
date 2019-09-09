;Sumatoria.asm: realiza la sumatoria de un numero
;Author: Azarias Ruiz
;Date: Agosto 2019
.model small
.stack 100h
    CR equ 13d
    LF equ 10d

.data
    msg db "Ingrese un valor numerico (01 al 13):", "$"
    incorrecto db CR, LF, "Valor incorrecto",CR, LF, "$"
    enter db CR, LF, "$"
    
.code
start:
    mov ax, @data
    mov ds, ax
    mov ax, offset msg 
    call puts
    call nro_dos_digitos
    cmp bh, 00d
    je no_numero
    mov ax, offset enter 
    call puts
    call sumatoria
    call finish
    
    sumatoria:
        mov bl, 00d          ;suma
        mov cl, 01d          ;contador
        mov al, cl
        add bl, cl
        inc cl
        call MOSTRAR_NUM_DOS_DIGITOS
        bucle:
            cmp bh, cl
            jge sumar  
            mov al, '='
            call putc
            mov al, bl
            call MOSTRAR_NUM_DOS_DIGITOS
            call finish
   
        sumar:
            add bl, cl
            mov al, 43d     ;'+'
            call putc
            mov al, cl
            inc cl
            call MOSTRAR_NUM_DOS_DIGITOS
            jmp bucle
        ret
    
    no_numero:
        mov ax, offset incorrecto
        call puts
        jmp start 
    
    nro_dos_digitos:     ;carga un numero de dos digitos en bh
        call geti
        mov bl, 10
        mul bl
        mov bh, al
        call geti
        add bh, al
        ret
        
    MOSTRAR_NUM_DOS_DIGITOS:
        ;Muestra un numero de dos digitos cargado AL
        push bx ; save bx
        push cx ; save cx
        push dx ; save dx
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
        pop dx ; restore dx
        pop cx ; restore cx
        pop bx ; restore bx
        ret
    
    geti:               ;carga un decimal en al
        call getc
        cmp al, 48d
        jl no_numero
        cmp al, 57d
        jg no_numero 
        sub al, 48d
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