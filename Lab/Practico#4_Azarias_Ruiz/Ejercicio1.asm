;Calculadora.asm 
;Author: Azarias Ruiz
;Date: Agosto 2019
.model small
.stack 100h
    CR equ 13d
    LF equ 10d

.data
    u db ?
    d db ?
    nro1 db ?
    nro2 db ?
    op db ?
.code
start:
    call nro_dos_digitos
    mov nro1, bh
    ask_again:
        call getc
        mov op, al
        cmp op, 's'             ;'s'= sumatoria
        je sumatoria
        cmp op, 102d            ;'f'= fibonacci
        je fibonacci
        call nro_dos_digitos
        mov nro2, bh
        cmp op, 43d             ;'+'= sumar
        je sumar                
        cmp op, 45d             ;'-'= restar
        je restar
        cmp op, 109d            ;'m'= multiplicar
        je multiplicar
        cmp op, 100d            ;'d'= dividir
        je dividir              
        cmp op, 112d            ;'p'= potencia
        je potencia
        
        jmp finish
    
    
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
        
    sumar:
        mov bh, nro1
        add bh, nro2
        mov nro1, bh
        mov al, "="
        call putc
        mov al, bh
        call MOSTRAR_NUM_DOS_DIGITOS
        jmp ask_again
        ret
        
    restar:
        mov bh, nro1
        sub bh, nro2
        mov nro1, bh
        mov al, "="
        call putc
        mov al, bh
        call MOSTRAR_NUM_DOS_DIGITOS
        jmp ask_again
        ret
        
    multiplicar:
        mov ah, 0d
        mov al, nro1
        mov bl, nro2
        mul bl
        mov nro1, al		;resultado se guarda en al
        mov al, "="
        call putc
        mov al, nro1
        call MOSTRAR_NUM_DOS_DIGITOS
        jmp ask_again
        ret
        
    dividir:
        mov ah, 0d
        mov al, nro1
        mov bl, nro2
        div bl
        mov nro1, al
        mov al, "="
        call putc
        mov al, nro1
        call MOSTRAR_NUM_DOS_DIGITOS
        jmp ask_again
        ret
        
    potencia:
        mov ah, 0d
        mov al, nro1
        mov bh, nro2
        sub bh, 1d
        aux:
            cmp bh, 0d
            jg elevar
            mov nro1, al
            mov al, "="
            call putc
            mov al, nro1
            call MOSTRAR_NUM_DOS_DIGITOS
            jmp ask_again
        ret
        
        elevar:
            mov bl, nro1      ;realiza una copia de al= nro1
            mul bl
            dec bh
            jmp aux
            ret
        
    sumatoria:
        mov al, nro1
        mov bl, 0d
        mov cl, 0d
        aux2:
            cmp al, cl
            jg sum
            mov nro1, bl
            mov al, "="
            call putc
            mov al, nro1
            call MOSTRAR_NUM_DOS_DIGITOS
            jmp ask_again
   
        sum:
            inc cl
            add bl, cl
            jmp aux2
            ret
        
    fibonacci:
        mov al, nro1
        mov bh, 0
        mov cl, 1
        mov bl, 1       ;contador
        mov dh, cl      ;dh= 1
        mov dl, cl
        bucle:
            cmp al, bl
            jg sum1
            jmp imprimir
            
        sum1:
            add bh, dl 
            mov dl, bh      
            inc bl
            cmp al, bl
            jg sum2
            jmp imprimir
            
        sum2:   
            add bh, dh
            mov dh, bh
            inc bl
            jmp bucle
            
        imprimir:
            mov nro1, bh
            mov al, "="
            call putc
            mov al, nro1
            call MOSTRAR_NUM_DOS_DIGITOS
            jmp ask_again

    
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