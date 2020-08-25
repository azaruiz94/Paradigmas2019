;Votaciones.asm
;Author: Azarias Ruiz
;Date: Agosto 2019
.model small
.stack 100h
    CR equ 13d
    LF equ 10d
	
.data
    edadMsg db "Ingrese su edad (01 al 99):", "$"
    sexoMsg db CR, LF, "Ingrese su sexo (f-F/m-M):", "$"
    votaMsg db CR, LF, "Usted vota en: ","$"
    noVota db CR, LF, "Usted no puede votar.", CR, LF, "$"
    lugares db "CREE$", "CTN$", "UNI$"
    edad db ?
    sexo db ?
	
.code
start:
    mov ax, @data
    mov ds, ax
    mov ax, offset edadMsg 
    call puts
    call nro_dos_digitos
    mov edad, bh
    cmp edad, 15d
    jl no_permitido
    cmp edad, 71d
    jg CREE
    cmp edad, 51d
    jge verificar_edad_max2
    mov ax, offset sexoMsg 
    call puts
    call getc
    mov sexo, al
    cmp edad, 16d
    jge verificar_edad_max 
    call finish
        
    verificar_edad_max:
        cmp edad, 50d
        jle verificar_sexo
        
    verificar_edad_max2:
        cmp edad, 70d
        jle UNI
        
    verificar_sexo:
        cmp sexo, 109d
        je CREE
        cmp sexo, 77d
        je CREE
        cmp sexo, 102d
        je CTN
        cmp sexo, 70d
        je CTN
        
    CREE:
        mov ax, offset votaMsg
        call puts
        mov ax, offset lugares[0]
        call puts
        jmp finish   
        
    CTN:
        mov ax, offset votaMsg
        call puts
        mov ax, offset lugares[5]
        call puts
        jmp finish
        
    UNI:
        mov ax, offset votaMsg
        call puts
        mov ax, offset lugares[9]
        call puts
        jmp finish
        
    no_permitido:
        mov ax, offset noVota
        call puts
        jmp finish
         
    nro_dos_digitos:     ;carga un numero de dos digitos en bh
        call geti
        mov bl, 10
        mul bl
        mov bh, al
        call geti
        add bh, al
        ret
        
    geti:               ;carga un decimal en al
        call getc
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