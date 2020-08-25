;Caracteres2.asm: 
;Author: Azarias Ruiz
;Date: Agosto 2019
.model small
.stack 100h
    CR equ 13d
    LF equ 10d

.data
    msg db "Ingrese texto:", "$"
    enter db CR,LF, '$'
    array db 30 dup('$')
    
.code
start:
    mov ax, @data
    mov ds, ax
    mov ax, offset msg 
    call puts
    mov DI, 0
    leer_entradas:
        call getc
        cmp al, 13d
        je mostrar_palabra
        sub al, 32         ;conversion a mayuscula
        mov array[DI], al
        inc DI
        jmp leer_entradas
        
        
    mostrar_palabra:
        mov ax, offset enter
        call puts
        mov ax, offset array
        call puts 
        jmp finish
    
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