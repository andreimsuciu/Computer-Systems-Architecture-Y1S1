;Assignment 3 - Suciu Andrei-Mircea
;Additions and substractions
;a - byte, b - word, c - double word, d - qword - Unsigned representation
;21:(c-a) + (b - d) +d 

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
    c dd 230
    d dq 142

; our code starts here
segment code use32 class=code
    start:
        mov eax, 0
        mov al, [a]    ;converted a,byte to double word
        mov ecx, [c]    
        sub ecx, eax    ;ecx = c-a
        
        mov eax, 0
        mov ax, [b]     ;converted b to double word
        mov edx, 0      ;converted b to quadword, edx:eax=b
        
        sub eax, dword[d]
        sbb edx, dword[d+4] ; edx:eax=b-d
        
        mov ebx, 0     ;converted c-a to qword, ebx:ecx=c-a
        
        add eax, ecx
        adc ebx, edx    ;ebx:eax=(c-a) + (b - d)
        
        add eax, dword[d]       
        adc ebx, dword[d+4]   ;ebx:eax=(c-a) + (b - d) +d 
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
