;Multiplo.asm.
;Indica si A es multiplo de B y viceversa 
;Author: Azarias Ruiz
;Date: Agosto 2019
.model small
.stack 100h
    CR equ 13d
    LF equ 10d

.data
    numberA db CR, LF, "Ingrese numero A:", "$" 
    numberB db CR, LF, "Ingrese numero B:", "$"
    primoMsg db " es primo de ", "$"
    noPrimoMsg db " no es primo de ", "$"
    enter db CR, LF, "$"
.code
start:
    mov ax, @data
    mov ds, ax
    mov ax, offset numberA 
    call puts
    call nro_dos_digitos
    mov cl, bh              ;cl= numero1
    mov ax, offset numberB
    call puts
    call nro_dos_digitos    ;ch= numero2
    mov ch, bh
    cmp cl, ch              ;si cl>ch
    jg  op_condicional1
    cmp ch, cl              ;sin ch>cl
    jg op_condicional2
    
    
    op_condicional1:
        mov ah, 0d              ;clean register
        mov al, cl              ;AL = AX / operand
        div ch                  ;AH = remainder (modulus)
        cmp ah, 0d
        je primo
        cmp ah, 0d
        jg no_primo

    op_condicional2:
        mov ah, 0d              ;clean register
        mov al, ch              ;AL = AX / operand
        div cl                  ;AH = remainder (modulus)
        cmp ah, 0d
        je primo
        cmp ah, 0d
        jg no_primo 
        
    primo:
        mov ax, offset enter
        call puts
        mov al, cl
        call MOSTRAR_NUM_DOS_DIGITOS
        mov ax, offset primoMsg
        call puts
        mov al, ch
        call MOSTRAR_NUM_DOS_DIGITOS
        jmp finish
    
    no_primo:
        mov ax, offset enter
        call puts
        mov al, cl
        call MOSTRAR_NUM_DOS_DIGITOS
        mov ax, offset noPrimoMsg
        call puts
        mov al, ch
        call MOSTRAR_NUM_DOS_DIGITOS
        jmp finish
        
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