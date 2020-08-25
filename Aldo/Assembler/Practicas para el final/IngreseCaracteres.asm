.model small
.stack 100h 
    CR equ 13d
    LF equ 10d
    TAM equ 10d
.data
    msg db 'Ingrese caracteres: ', '$'
    arreglo db 10 dup('$')
.code

start:
    mov ax, @data
    mov ds, ax
    mov ax, offset msg
    call puts
    mov DI, 0d
    obtener_frase:
        call getc
        mov arreglo[SI], al
        inc DI
        cmp DI, TAM
        jl obtener_frase
        cmp DI, TAM
        je play_beep
        
    play_beep:
        mov al, 07d
        call putc
        jmp finish
    
    getc:
        push bx
        push cx
        push dx
        mov ah, 1h
        int 21h
        pop dx
        pop cx
        pop bx
        ret  
        
    putc: 
        push ax
        push bx
        push cx
        push dx
        mov dl, al
        mov ah, 2h
        int 21h
        pop dx
        pop cx
        pop bx
        pop ax
        ret
    puts: 
        push ax
        push bx
        push cx
        push dx
        mov dx, ax
        mov ah, 9h
        int 21h
        pop dx
        pop cx
        pop bx
        pop ax
        ret  
        
    finish:
        mov ax, 4c00h
        int 21h
        
end start