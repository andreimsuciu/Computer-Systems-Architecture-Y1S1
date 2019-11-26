;Assignment 6 - Suciu Andrei-Mircea - 917

;5.Two byte strings s1 and s2 are given. Build the byte string d such that, for every byte s2[i] in s2, d[i] contains either the position of byte s2[i] in s1, either the value of 0.
;Example:
;pos:1 2 3 4 5
;s1: 7, 33, 55, 19, 46
;s2: 33, 21, 7, 13, 27, 19, 55, 1, 46 
;d: 2,  0, 1, 0, 0, 4, 3, 0, 5

bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    s1 db 7, 33, 55, 19, 46 ; declare array s1
    l1 equ $-s1 ; the length of s1 is saved in the constant l1
    s2 db 33, 21, 7, 13, 27, 19, 55, 1, 46 ; declare array s2
    l2 equ $-s2 ; the length of s2 is saved in the constant l2
    d times l2 db 0 ; allocation of a space of dimension l for the destination array and the initialization of this array
    
; our code starts here
segment code use32 class=code
    start:
        mov ecx, l2     ;we will loop through s2, so we move l2 in ecx
        mov esi, s2     ;load offset s2 in ESI
        mov ebx, 0      ;set ebx to 0
        cld     ;parse the string from left to right(DF=0).            
        jecxz Exit
        loops2:
            lodsb           ;in al -> byte of s2 , inc esi
            mov edi, s1     ;load offset s1 in EDI
            mov bl, 1
            loops1:
                cmp bl, l1           ;checks if we went through all s1
                ja not_found_in_s1   ;if we did, it means that the number we're looking for is not in s1, so we jump over those instructions
                
                scasb                   ;compares al to byte from adress <ES:EDI>; inc edi
                jne noteq               ;skips over the instructions that takes care of the case in which s2[i]=s1[j]
                dec esi
                mov [d+esi-s2], bl    ;put j in d
                inc esi
                jmp continue_loops2     ;jump back in the main loop
                
                noteq:      ;case in which the number is not in s1[i], but we haven't finished looking
                inc bl      ;inc bl to continue loop
                jmp loops1  ;jump back in loop
                
                not_found_in_s1:
                jmp continue_loops2    ;go back into main loop
            continue_loops2:    
        loop loops2
        Exit:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
