;NumerosPares.asm: Indica si el numero ingresado es para o impar. 
;Author: Azarias Ruiz
;Date: Agosto 2019
.model small
.stack 100h
    CR equ 13d
    LF equ 10d

.data
    msg db "Ingrese un valor numerico (01-99):", "$" 
    no_numero db CR, LF, "El valor ingresado no es un numero:", "$"
    nro_par db CR, LF, "El numero es par", "$"
    nro_impar db CR, LF, "El numero es impar","$"
    enter db CR, LF, "$"
.code
start:
    mov ax, @data
    mov ds, ax
    bucle:
        mov ax, offset msg 
        call puts
        call nro_dos_digitos
        mov ah, 0d          ;limpio el registro
        mov bl, 2d          ;bl=2
        div bl
        cmp ah, 0d
        je es_par
        cmp ah, 0d
        jg es_impar
        jmp bucle
        
    es_par:
        mov ax, offset nro_par
        call puts
        mov ax, offset enter
        call puts
        jmp bucle
    
    es_impar:
        mov ax, offset nro_impar
        call puts
        mov ax, offset enter
        call puts
        jmp bucle
    
    nro_invalido:
        mov ax, offset no_numero
        call puts
        jmp bucle
        
    MOSTRAR_NUM_DOS_DIGITOS:
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
        
    geti:               ;carga un decimal en al
        call getc
        cmp al, 48d
        jl nro_invalido
        cmp al, 57d
        jg nro_invalido
        sub al, 48d
        ret
        
    nro_dos_digitos:     ;carga un numero de dos digitos en bh
        call geti
        mov bl, 10
        mul bl
        mov bh, al
        call geti
        add bh, al
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