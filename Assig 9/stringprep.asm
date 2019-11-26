; we need to avoid multiple inclusion of this file
%ifndef _STRINGPREP_ASM_ ; if _STRINGPREP_ASM_ is not defined
%define _STRINGPREP_ASM_ ; then we define it

; procedure definition
string_prep:                  
	mov esi, [esp+8] ;put offset in esi
    mov ecx, [esp+4] ;the length of our string
    add esi, ecx
    sub esi, 1
    std ;parse the string from right to left(DF=0)
    ret  4
%endif