;Figura.asm: Imprime una figura con asteriscos.
;Author: Azarias Ruiz
;Date: Agosto 2019
.model small
.stack 100h
    CR equ 13d
    LF equ 10d

.data
    msg db "Ingrese un numero: ", "$"
    enter db CR, LF, "$"
    azteriscos db ?
    espacios db ?

.code
start:
    mov ax, @data
    mov ds, ax
    mov ax, offset msg 
    call puts
    call getc               ;obtiene la entrada del usuario
    mov bl, al
    sub bl, 48d             ;bl -> entrada del usuario
    mov bh, bl 
    mov dl, 1               ;contador=0
    bucle:
        dec bh
        cmp bh, 0d
        jl parte_inferior
        call imprimir_enter
        mov ch, bh
        cmp bh, 0d
        jg linea_espacios
        bucle2:
            mov cl, bl
            sub cl, bh
            cmp cl, bl
            jle linea_asterizcos
            inc dl              ;contador++
            cmp dl, bl          
            jl bucle
            jmp finish
            
    parte_inferior:
        mov bh, bl              ;bh= entrada del usuario
        mov dl, 1               ;contador=0
        bucle3:
            dec bh       
            cmp bh, 0d
            jle finish
            call imprimir_enter
            mov cl, bh
            cmp bh, 0d
            jg linea_asterizcos2
            ;jmp bucle3
            
    
    linea_asterizcos:       ;imprime una linea de asterizcos dependiendo del numero en cl, cl>1
        mov al, '*'
        call putc
        dec cl
        cmp cl, 0d
        jg linea_asterizcos
        jmp bucle
        
    linea_asterizcos2:       ;imprime una linea de asterizcos dependiendo del numero en cl, cl>1
        mov al, '*'
        call putc
        dec cl
        cmp cl, 0d
        jg linea_asterizcos2
        jmp bucle3 
    
    linea_espacios:         ;imprime una linea de espacios dependiendo del numero en ch, ch>1
        mov al, ' '
        call putc
        dec ch
        cmp ch, 0d
        jg linea_espacios
        jmp bucle2   
        
    imprimir_enter:
        mov ax, offset enter
        call puts
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