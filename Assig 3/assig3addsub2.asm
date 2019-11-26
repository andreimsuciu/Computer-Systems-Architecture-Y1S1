;Assignment 3 - Suciu Andrei-Mircea
;Additions and substractions
;a - byte, b - word, c - double word, d - qword - Signed representation
;21:d-a+(b+a-c)  

bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db 21
    b dw 200
    c dd 210
    d dq 142

; our code starts here
segment code use32 class=code
    start:
        mov al, [a]    
        cbw
        cwd
        cwde
        cdq ;converted a to qword, edx:eax=a
        
        mov ebx, dword[d]
        mov ecx, dword[d+4]      ;ecx:ebx=d
        
        sub ebx,eax
        sbb ecx,edx     ;ecx:ebx=d-a
        
        mov al, [a]
        cbw
        add ax, [b]; ax=b+a
        cwd; converted b+a to dword, dx:ax=b+a
        sub ax, word[c]
        sub dx, word[c+2]; dx:ax=b+a-c
        push dx
        push ax
        pop eax; eax=b+a-c
        cdq; edx:eax=b+a-c
        
        add eax,ebx
        adc edx,ecx;edx:eax=d-a+(b+a-c)  
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
