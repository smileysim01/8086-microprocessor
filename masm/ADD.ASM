data_here segment
a db 04h
b db 06h
c db 00h
data_here ends

code_here segment
assume cs:code_here, ds:data_here
start: mov ax, data_here
mov ds, ax
mov ah, a
mov al, b
add ah, al
mov c, ah
mov ah, 4ch
int 21h
code_here ends
end start
