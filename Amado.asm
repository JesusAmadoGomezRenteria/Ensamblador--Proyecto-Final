    
org 100h




Limpia MACRO ;Donde hace una limpia del programa 
   mov ah, 0FH
    int 10h
    mov ah, 0
    int 10h
ENDM 

mPausa MACRO 
    mov ah,7
    int  21h ;Hace una interrupcion 
ENDM

mImprimC MACRO t
   lea dx, t
   mov ah, 9 
   int 21h 
ENDM            

mPosrc MACRO r,c   
    
mov bh,0 ;Inicia en la pantalla
mov dh,r ;inicia la posicion del reglon 
mov dl,c ;indica el rango donde va estar el renglon
mov ah,2 ;El servicio hace un interrupcion 
int 10h
ENDM  


.MODEL small, c 
.STACK
.DATA


;Son las cadenas que se mandaran en la pantalla
text1 db 'Proyecto final $'
text2 db '_____Para salir presione la tecla A de Amado_____$'  
text3 db 'Jesus Amado Gomez Renteria Ingeniero en Computacion $'  
text4 db db 020h,0B0h,0b1h,0b2h,"Presione la tecla A para iniciar la animacion$"   


mov ah, 0
int 16h
.CODE
.STARTUP


mPosrc 10,30 
mImprimC text1 
mPosrc 13,15 
mImprimC text2 


mov ah, 0
int 16h 
MOV AX,0600H ; Peticion para limpiar pantalla
MOV BH,0fH ; Color de letra ==9 "Azul Clar, para el fonfo negro es: mov bh,0fh y azul: bh,89h "

MOV CX,0000H ; Se posiciona el cursor en Ren=0 Col=0
MOV DX,184FH ; Cursor al final de la pantalla Ren=24(18)
)
INT 10H ; INTERRUPCION AL BIOS
;------------------------------------------------------------------------------
MOV AH,02H ; Peticion para colocar el cursor
MOV BH,00 ; Nunmero de pagina a imprimir
MOV DH,12 ; Cursor en el renglon 05
MOV DL,0 ; Cursor en la columna 05

mPosrc 12,15
mImprimC text3
mPosrc 13,15
mImprimC text4
    
    
    
mov ah, 0
int 16h
MOV AX,0600H ; Peticion para limpiar pantalla
MOV BH,0fh
MOV CX,0000H ; Se posiciona el cursor en Ren=0 Col=0
MOV DX,184FH ; Cursor al final de la pantalla Ren=24(18)  
INT 10H
MOV AH,02H ; Peticion para colocar el cursor
MOV BH,00 ; Nunmero de pagina a imprimir
MOV DH,12 ; Cursor en el renglon 05
MOV DL,0



mov cx, veces
mov cursor,0

inicio:
mov ah,2
mov Dl,cursor
mov dh,12
int 10h

mov ah,9
mov dx, offset CursorDer
int 21h

inc cursor        ;incrementamos el cursor
loop inicio 

;se invierte rl movimiento decrrementando el cursor

mov cx,veces    ;otras 20 veces de dere a izq


DeraIzq:

;ubicamos el cursor
mov ah,2
mov Dl,cursor     ;columna
mov dh,12       ;renglon
int 10h


mov ah,9
mov dx,offset CursorIzq 
int 21h

dec cursor     ;decrementamos el cursor
loop DeraIzq   

;termina el ciclo

mov ah,1
int 16h

mov cx,Veces
jz inicio



fin:

mov ah,9
mov dx,offset TitFinal
int 21h

mov ah,2
int 21h

ret
veces dw 77
cursor db 0
CursorDer db 020h,0B0h,0b1h,0b2h,"$"
CursorIzq db 0b2h,0b1h,0b0h,020h,"$"
TitFinal db 10, 13,

