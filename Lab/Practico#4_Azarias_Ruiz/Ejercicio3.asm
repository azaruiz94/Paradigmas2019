;Caracteres.asm: 
;Author: Azarias Ruiz
;Date: Agosto 2019
.model small
.stack 100h
    CR equ 13d
    LF equ 10d

.data
    msg db "Ingrese texto:", "$"
    msg2 db CR, LF, "Total de caracteres ingresados: ", "$"

.code
start:
    mov ax, @data
    mov ds, ax
    mov ax, offset msg 
    call puts
    mov bl, 0
    leer_entradas:
        call getc
        cmp al, 13d
        je mostrar_cantidad
        inc bl
        jmp leer_entradas
        
    mostrar_cantidad:
        mov ax, offset msg2
        call puts 
        mov al, bl
        call MOSTRAR_NUM_DOS_DIGITOS
        mov al, 007d
        call putc
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