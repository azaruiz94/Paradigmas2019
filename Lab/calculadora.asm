; Author: Azarias Ruiz
; Date: 
.model small
.stack 100h 
.data 
	CR equ 13d
	LF equ 10d
    message db "Ingrese un numero: ", CR, LF,'$'
    operation db "Ingrese operacion: ", CR, LF,'$'
    result db "El resultado es: ", CR, LF,'$' 
.code

start:
    mov ax, @data
    mov ds, ax
    mov dx, offset message  ;almacena en dx el mensaje
    call puts               ;imprime el mensaje guardado en ax
    call getc
    call convert_to_int
    mov  cl, al             ;guardo el primer numero en cl
    mov dx, offset operation
    call puts
    call getc               
    mov bl, al              ;guarda la operacion en bl
    mov dx, offset message
    call puts
    call getc
    call convert_to_int
    mov  ch, al             ;guardo el segundo numero en ch
    cmp bl, 43d
    je suma 
    cmp bl, 45d
    je resta 
	
	resultado:
	    mov dx, offset result
        call puts
        add cl, 48d             ;convierte a ascci
        mov dl, cl
        call putc
        ret
    
    suma:                   ;retorna el resultado en cl
        add cl, ch
        call resultado
        call start
        ret
        
    resta:                  ;retorna el resultado en cl
        sub cl, ch 
        call resultado
        call start
        ret
        
	putc:                   ;muestra el caracter en dl
		mov ah, 2h
		int 21h
		ret
	getc:                   ;guarda el caracter dentro de al
		mov ah, 1h
		int 21h
		ret
	puts: 			        ;muestra un string terminado por $
		mov ah, 9h	        ;dx contiene la direccion del string
		int 21h
		ret
		
	convert_to_int:
	    sub al, 48d
	    ret    
		
		
	finish: 
		mov ax, 4c00h       ;retorna a ms-dos
		int 21h
		ret
		  
		
end start