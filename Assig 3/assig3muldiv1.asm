;Assignment 3 - Suciu Andrei-Mircea
;Multiplications, divisions - Unsigned representation
;21:(a*a/b+b*b)/(2+b)+e-x; a-byte; b-word; e-doubleword; x-qword

bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db 7
    b dw 20
    e dd 45
    x dq 60

; our code starts here
segment code use32 class=code
    start:
        mov al, [a]
        mul byte[a] ;ax=a
        mov dx,0 ;dx:ax=a*a
        
        div word[b]; ax=a*a/b
        mov bx,ax; bx=a*a/b
        
        mov ax, [b]
        mul word[b]; dx:ax=b*b
        mov cx,0 ; cx:bx=a*a/b
        
        add bx,ax
        adc cx,dx; cx:bx=a*a/b+b*b
        
        ;converting in case b+2 is more than a word 
        push cx
        push bx
        pop eax; eax=a*a/b+b*b
        mov edx, 0; edx:eax=a*a/b+b*b
        mov ebx, 0
        mov bx, [b]; ebx=b
        add ebx ,2;ebx=b + 2
        div ebx; eax=a*a/b+b*b)/(2+b)
        
        add eax, [e] ; eax=a*a/b+b*b)/(2+b)+e
        mov ebx, 0 ; ebx:eax=a*a/b+b*b)/(2+b)+e
        
        sub eax, dword[x]
        sbb ebx, dword[x+4]; ebx:eax=(a*a/b+b*b)/(2+b)+e-x
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
