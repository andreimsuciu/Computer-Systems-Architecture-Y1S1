;Multiplications, division:a,b,c,d-byte, e,f,g,h-word  8.2*(a+b)-e 

bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ;a,b,c,d-byte, e,f,g,h-word
    a db 3
    b db 2
    e dw 7

; our code starts here
segment code use32 class=code
    start:
        ;2*(a+b)-e 
        mov eax, 0
        mov ebx, 0
        mov al, [a]     ;al = a =3
        add al, [b]     ;al = a+b = 5
        mov bl, 2       ;bl = 2
        mul bl          ;ax = 2*(a+b)=10
        sub ax, [e]     ;ax = 2*(a+b)-e = 3
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
