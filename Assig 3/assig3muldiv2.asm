;Assignment 3 - Suciu Andrei-Mircea
;Multiplications, divisions - Signed representation
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
        imul byte[a] ;ax=a*a
        cwd ; dx:ax=a*a
        
        idiv word[b];ax=a*a/b
        mov bx,ax ;bx=a*a/b
        
        mov ax, [b]
        imul word[b] ;dx:ax=b*b
        push dx
        push ax
        pop ecx; ecx=b*b
        
        mov ax, [b]
        cwd ;dx:ax=b
        push dx
        push ax
        pop edx
        add edx, 2; edx= b+2
        
        mov ax,bx; ax=a*a/b
        mov ebx, edx ;ebx=b+2
        cwd ;dx:ax=a*a/b
        push dx
        push ax
        pop eax;ebx=a*a/b
        add eax,ecx ;eax=a*a/b+b*b
        
        
        cdq ; edx:eax=a*a/b+b*b
        idiv ebx ;eax=(a*a/b+b*b)/(2+b)
        
        add eax, [e]; eax=(a*a/b+b*b)/(2+b)+e
        cdq ;edx:eax=(a*a/b+b*b)/(2+b)+e
        
        sub eax, dword[x]
        sbb edx, dword[x+4] ;edx:eax=(a*a/b+b*b)/(2+b)+e-x
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
