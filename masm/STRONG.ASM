data segment
str db 'Enter a number:$'
msg1 db 0dh, 0ah, 'Number is strong', 0dh, 0ah, '$'
msg2 db 0dh, 0ah, 'Number is not strong', 0dh, 0ah, '$'
num dw ?
ten db 10
q db ?
rem db ?
data ends

code segment
assume cs: code, ds: data, es: data
start:  mov ax, data
        mov ds, ax
        mov es, ax
        mov ah, 09h
        mov dx, offset str
        int 21h
        mov bl, 0
        mov dh, 0
        input:  mov ah, 01h    ;al -> inputted_number + 32
                int 21h
                cmp al, 13
                je inputted
        sub al, 30h
        mov dl, al
        mov ax, bx
        mul ten
        add ax, dx
        mov bx, ax
        jmp input
        inputted:       mov num, bx
                        mov ax, num
                        mov bx, 0
        do:     cmp al,0
                je done
                div ten         ; al->quotient, ah->remainder
                mov rem, ah
                mov ah, 0
                mov q, al
                mov al, 1
                mov cl, rem
                jz fact1
                fact:   mul cl
                        dec cl
                        cmp cl, 1
                        jg fact
                fact1:   add bx, ax      ; bx -> bx + rem!
                        mov ax, 0
                        mov al, q
                        jmp do
        done:   mov ax, num
                cmp ax, bx
                jne not_strong
                lea dx, msg1
                mov ah, 09
                int 21h
                jmp last
        not_strong:     lea dx, msg2
                        mov ah, 09
                        int 21h
        last:   mov ah, 4ch
                int 21h
        code ends
end start






