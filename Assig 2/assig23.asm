;Multiplications, division: a,b,c - byte, d - word,  8.(100*a+d+5-75*b)/(c-5)

bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db 2
    b db 3
    c db 7
    d dw 20

; our code starts here
segment code use32 class=code
    start:
        ;a,b,c - byte, d - word
        ;(100*a+d+5-75*b)/(c-5) 
        mov eax, 0
        mov ebx, 0
        mov al, [a]     ; al = 2
        mov ah, 100     ; ah = 100
        mul ah          ; ax = 200
        add ax, [d]     ; ax = ax + b = 220
        add ax, 5       ; ax = ax + 5 = 225
        mov bx, ax      ; bx = 100*a+d+5 = 225
        mov al, [b]     ; al = b = 3
        mov ah, 75      ; ah = 75
        mul ah          ; ax = 75*3 = 225
        add ax, bx      ; ax = 100*a+d+5-75*b = 450
        mov bl, [c]     ; bl = c = 7 
        sub bl, 5       ; bl = c - 5 = 2
        div bl          ; al = 225, ah = 0
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
