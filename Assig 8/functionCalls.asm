;Assignment 8 - Suciu Andrei-Mircea - 917
;Function Calls

;12.A negative number a (a: dword) is given. 
;Display the value of that number in base 10 and in the base 16 in the following format: "a = <base_10> (base 10), a = <base_16> (base 16)" 

bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import printf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a dd -34
    format dd "a = %d(base 10), a = %x(base 16)", 0

; our code starts here
segment code use32 class=code
    start:
        mov eax, [a]    ; a is a double word, so we put it in eax
        
        
        push dword [a]     ;push a onto the stack, for its hexa representation 
        push dword [a]      ;push a onto the stack, for its signed decimal representation
        push dword format   ;push the format onto the stack
        call [printf]       ; call the function
        add esp, 4*3        ;clear the stack
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
