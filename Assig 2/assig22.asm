;Additions and substractions - a,b,c,d - word: 8.(b+c+d)-(a+a) 

bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a dw 12
    b dw 22
    c dw 4
    d dw 20

; our code starts here
segment code use32 class=code
    start:
        ;(b+c+d)-(a+a)
        mov ebx, 0
        mov eax, 0
        ;b+c+d 
        mov ax, [b]     ;al = 22
        add ax, [c]     ;al = 26
        add ax, [d]     ;al = 46
        ;a+a
        mov bx, [a]     ;bx = 12
        add bx, [a]     ;bx = 24
        ;op
        sub ax, bx      ;r = 22
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
