.model small
.stack 100h 
    CR equ 13d
    LF equ 10d
.data   
    msg db '?', '$'
    enter db CR, LF, '$'
.code

start:
    mov ax, @data
    mov ds, ax
    mov al, 07d
    call putc
    mov ax, offset msg
    call puts
    call getc
    mov cl, al
    mov ax, offset enter
    call puts
    mov al, cl
    call putc
    call fin
    
    getc:           ;guarda la entrada en al
        push bx
        push cx
        push dx
        mov ah, 1h
        int 21h
        pop dx
        pop cx
        pop bx
        ret
    putc:           ;muesta lo que hay en dl
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
    puts:           ;muestra lo que hay en ax
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
    fin:
        mov ax, 4c00h
        int 21h
        
end start
