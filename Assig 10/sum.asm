bits 32
global _sumN
segment data public data use32
segment code public code use32
_sumN:
    ; create a stack frame
	push ebp
	mov ebp, esp	
    
    ;do operations
	mov eax, [ebp+8]
	add eax, [ebp+12]
    sub eax, [ebp+16]
    
    ; restore the stack frame
	mov esp, ebp
	pop ebp
    
    ;return
    ret