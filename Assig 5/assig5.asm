;Assignment 5 - Suciu Andrei-Mircea - 917

;Se dau 2 siruri de octeti S1 si S2 de aceeasi lungime. Sa se construiasca sirul D astfel incat ;fiecare element din D sa reprezinte minumul dintre elementele de pe pozitiile corespunzatoare din ;S1 si S2.
 
;Exemplu:
;   S1: 1, 3, 6, 2, 3, 7
;   S2: 6, 3, 8, 1, 2, 5
;   D:  1, 3, 6, 1, 2, 5

bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    s1 db 1, 3, 6, 2, 3, 7 ; declare array s1
    s2 db 6, 3, 8, 1, 2, 5 ; declare array s2
    l equ $-s2 ; the length of the arrays is saved in the constant l
    d times l db 0 ; allocation of a space of dimension l for the destination array and the initialization of this array

; our code starts here
segment code use32 class=code
    start:
        mov ecx, l ; we will execute the loop l times
        mov esi, 0 ; initializing the array index to 0
        jecxz Exit
        arrayloop:
            mov al, [s1+esi]    ; move the element in position esi from s1 to al
            mov bl, [s2+esi]    ; move the element in position esi from s2 to bl
            
            cmp al,bl           ; ficitional sub, dest=al, source=bl
            
            ja jumpover1        ; unsigned comparisson, if al>bl, then the minimum is in s2(bl), so we jump over next instruction
            minInS1:            ; if the program did not jump, it means that the minimum is located in s1
                mov [d+esi], al ; move the value of s1[esi],which is located in al to d[esi]
            jumpover1:
                     
            jbe jumpover2;unsigned comparisson,if al<bl, then the minimum is in s1(al), we also take here the case in which s1[esi]=s2[esi]; in this case we jump over next instruction
            minInS2:            ;if the program did not jump, it means that the minimum is located in s2
                mov [d+esi], bl ; move the value of s2[esi],which is located in bl to d[esi]
            jumpover2:
            inc esi             ; incrementing esi so that we move to the next position in the array
        loop arrayloop
        Exit:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
