
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

;Ejercicio 1

mov bx, '?'
mov cx, ' '
mov cx, 26d
mov bx, ax
mov dx, ax

;Ejercicio 2

;mov ax 3d   ;Falta una coma
;mov 23, ax  ;23 no es un registro
;mov cx, ch  ;No son compatibles
;move ax, 1h ;No existe la instruccion move
;add 2, cx   ;2 no es un registro
;add 3, 6    ;3 no es un registro
;inc ax, 2   ;inc recibe un solo registro

;Ejercicio 3 usando

;a) un registro
mov ax, 6
sub ax, 2
add ax, 5

;b) dos registros
mov ax, 6
mov bx, 2
sub ax, bx
add ax, 5

;c) 3 registros
mov ax, 6
mov bx, 2
mov cx, 5
sub ax, bx
add ax, cx

;Ejercicio 4

;a) a = b + c - d 
mov bx, 3   ;b
mov cx, 2   ;c
mov dx, 4   ;d
add bx, cx  ;b+c
sub bx, dx  ;(b+c)-d
mov ax, bx  ;a=(b+c)-d

;b)	z = x + y + w - v +u
mov ax, 2   ;x=2
mov bx, 3   ;y=3
mov cx, 4   ;w=4
mov dx, 5   ;v=5
add ax, bx
add ax, cx
sub ax, dx
mov bx, 1   ;u=1
add ax, bx

;Ejercicio 5
 
;a) a = b + c - d 
mov al, 5    ;b=5
mov ah, 3    ;c=3
mov bl, 1    ;d=1
add al, ah   ;b+c
sub al, bl   ;b+c-d
mov cl, al   ;a=b+c-d 
                   
;b)	z = x + y + w - v +u                  
mov al, 3    ;x=6
mov ah, 2    ;y=2
mov bl, 4    ;w=7
mov bh, 6    ;v=5
mov cl, 1    ;u=9
add al, ah   ;x+y
add al, bl   ;x+y+w
sub al, bh   ;x+y+w-v
add al, cl   ;x+y+w-v+u
mov ch, al   ;z=x+y+w-v+u

ret