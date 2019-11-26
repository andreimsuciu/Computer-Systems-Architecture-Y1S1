;Read from file numbers.txt a string of numbers. 
;Build a string D wich contains the readen numbers doubled and in reverse order that they were read. 
;Display the string on the screen.
;Ex: s: 12, 2, 4, 5, 0, 7 => 14, 0, 10, 8, 4, 24

;NB! The string in numbers.txt begins with a ' '

bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, fprintf, fclose, scanf, printf ,fread             
import exit msvcrt.dll    
import fopen msvcrt.dll
import fclose msvcrt.dll
import fprintf msvcrt.dll
import scanf msvcrt.dll 
import printf msvcrt.dll
import fread msvcrt.dll                         
                          
%include "stringprep.asm"
                          
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    file_name db "numbers.txt", 0   ; filename to be read
    access_mode db "r", 0       ; file access mode:
                                ; r - opens a file for reading. The file must exist. 
    file_descriptor dd -1       ; variable to hold the file descriptor
    len equ 100                 ; maximum number of characters to read
    s1 times len db 0         ; string to hold the array which is read from file
    s2 times len db 0         ; string to hold the array which is read from file
    space db " ",0
    ten db 10
    format dd "%d ", 0
    num dw 0
    mesaj db "Stringul este:", 13, 10, 0
    ascii_num db 48
    digits db 1
    
; our code starts here
segment code use32 class=code   
    start:
        push dword mesaj    ;pushing mesaj onto the stack
        call [printf]       ;printing the message
        add esp, 4*1
        
        push dword access_mode     
        push dword file_name
        call [fopen]
        add esp, 4*2                ; clean-up the stack

        mov [file_descriptor], eax  ; store the file descriptor returned by fopen

        ; check if fopen() has successfully created the file (EAX != 0)
        cmp eax, 0
        je final

        ; read the text from file using fread()
        ; after the fread() call, EAX will contain the number of chars we've read 
        ; eax = fread(text, 1, len, file_descriptor)
        push dword [file_descriptor]
        push dword len
        push dword 1
        push dword s1        
        call [fread]
        add esp, 4*4    ;read the string
        
        push dword s1
        push dword eax
        call string_prep 
        
        loopstring:
            push ecx
            std
            lodsb   ;s1[i] -> al, inc esi
                
            cmp al, byte[space] ;check wether we have new number
            je nextnumber
            ;creating a number
            xor ebx, ebx    ;clear ebx
            sub al, byte[ascii_num]     ;we make the character into an int
            mul byte[digits]    ;multiply the digit with multiples of 10 (1, 10, 100 etc)
            mov bx, [num]       ;move the previously obtained number in bx
            add ax, bx          ;add the two of them
            mov [num], ax       ;move the new number in the location of num
            mov al, byte[digits];move in al the multiple of 10
            mul byte[ten]
            mov [digits], ax    ;obtain multiple of 10 in [digits]
            
            jmp newchar
                
            nextnumber:
            ;printing the number
            push ecx        ;push ecx onto stack so we dont lose it
            xor eax, eax
            mov ax, [num]
            mov bl, 2
            mul bl          ;al; these instructions make sure to multiply num by 2 before printing it
            
            push dword eax
            push dword format
            call [printf]       ; call the function
            add esp, 4*2        ;clear the stack
                    
            mov ax, 0
            mov [num],ax    ;make num 0 for the next number 
            mov ax, 1
            mov [digits], ax ;make digits 1 for the next number
            
            newchar:
            pop ecx
        loop loopstring    
        
        
        ; call fclose() to close the file
        ; fclose(file_descriptor)
        push dword [file_descriptor]
        call [fclose]
        add esp, 4*1    ;closing numbers.txt

      final:
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
