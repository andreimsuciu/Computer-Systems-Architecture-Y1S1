;Simple exercises - Compute and analyze the result:8.128+127 
;Additions and substractions - a,b,c,d - byte; 8.(a+b-d)+(a-b-d) 

bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db 44
    b db 22
    c db 4
    d db 20

; our code starts here
segment code use32 class=code
    start:
        ;Simple exercises
        ;a,b,c,d - byte
        mov eax, 0
        mov al, 127 ;al = 127
        add al, 128 ;al = 255
        
        
        ;Additions, substractions
        mov ebx, 0
        mov eax, 0
        ;a+b-d
        mov al, [a]     ; al = 44
        add al, [b]     ; al = 66
        sub al, [d]     ; al = 62
        ;a-b-d
        mov bl, [a]     ; bl = 44
        sub bl, [b]     ; bl = 22
        sub bl, [d]     ; bl = 2
        ;(a+b-d)+(a-b-d)
        add al, bl ;r=al+bl=68
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
