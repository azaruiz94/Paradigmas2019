.model small
.stack 100h 
    CR equ 13d
    LF equ 10d

.data
    numero_msg db CR, LF, 'Ingrese un numero: ', '$'
    operacion_msg db CR, LF, 'Ingrese la operacion: ', '$'
    resultado_msg db CR, LF, 'El resultado es: ', '$'
    resultado db 0
.code

start:
    mov ax, @data
    mov ds, ax
    mov ax, offset numero_msg
    call puts
    call getc
    mov cl, al
    sub cl, 48d 
    mov ax, offset numero_msg
    call puts
    call getc
    mov ch, al
    sub ch, 48d
    mov ax, offset resultado_msg
    call puts
    call multiplicar
    mov al, resultado
    call putc
    mov ax, offset resultado_msg
    call puts
    call dividir
    mov al, resultado
    call putc
    call finish
    
    multiplicar:
        mov ah, 0d
        mov al, cl
        mov bl, ch
        mul bl
        add al, 48d
        mov resultado, al
        ret
        
    dividir:
        mov ah, 0d
        mov al, cl
        mov bl, ch
        div bl 
        add al, 48d
        mov resultado, al
        ret
    
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