;Assignment 8 - Suciu Andrei-Mircea - 917
;Text File Operations

;12.A file name is given (defined in the data segment). 
;Create a file with the given name, then read numbers from the keyboard and write those numbers in the file, until the value '0' is read from the keyboard. 

bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, fprintf, fclose, scanf, printf              
import exit msvcrt.dll    
import fopen msvcrt.dll
import fclose msvcrt.dll
import fprintf msvcrt.dll
import scanf msvcrt.dll 
import printf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    mesaj db "Enter a number:", 13, 10, 0   ;message to show up everytime input is required
    new_line db " ", 13, 10, 0    ;defining new line to print in the file
    new_line_format db "%s" 
    num dd 0    ;variable to hold the number read
    num_format db "%d", 0   ;format of out variable
    file_name db "readNumbers.txt", 0   ; filename to be created
    access_mode db "w", 0       ; file access mode:
                                ; w - creates an empty file for writing
    file_descriptor dd -1       ; variable to hold the file descriptor

; our code starts here
segment code use32 class=code
    start:
        push dword access_mode      ;pushing access_mode onto the stack
        push dword file_name        ;pushing file_name onto the stack
        call [fopen]        ;creating the file to be written in
        add esp, 4*2        ;clearing stack

        mov [file_descriptor], eax  ; store the file descriptor returned by fopen
        
        cmp eax,0       ;making sure that the file was created properly
        je final
        
        numberreading:
        
        push dword mesaj    ;pushing mesaj onto the stack
        call [printf]       ;printing the message
        add esp, 4*1
        
        push dword num    ;push the address at which num is stored onto the stack
        push dword num_format   ;push the format onto the stack
        call [scanf]        ;taking input from keyboard
        add esp, 4*2        ;clearing stack
        
        cmp [num],dword 0     ;making sure the user doen't want to stop the program
        je final2
        
        push dword [num]      ;pushing the value of the number onto the stack
        push dword num_format   ;pushing the number format onto the stack
        push dword [file_descriptor]        ;pushing the file_descriptor value onto the stack
        call [fprintf]      ;printing the number into the file
        add esp, 4*2        ;clearing the stack
        
        push dword new_line     ;pushing new line onto the stack
        ;push dword new_line_format      ;pushing the format of a new line onto the stack
        push dword [file_descriptor]        ;pushing the file_descriptor value onto the stack
        call [fprintf]      ;printing the new line into the file
        add esp, 4*2        ;clearing the stack
        
        jmp numberreading      ;jump to number_reading to read another number
        
        final2:
        push dword [file_descriptor]    ;pushing the file_descriptor value onto the stack
        call [fclose]       ;closing said file
        add esp, 4      ;clearing stack
        
        final:      ;ending program
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
