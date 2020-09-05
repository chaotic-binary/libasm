;	char *ft_strcpy(char *dest, const char *src); dest == rdi, src = rsi

global _ft_strcpy
section .text

_ft_strcpy:
	push	rdi
	push	rsi
	mov		rax, rdi 		; copy the pointer to dest

.loop:
	mov		dl, byte [rsi]	; copy the char of src to dl
	mov		byte [rdi], dl	; copy the char to dest
	test	dl, dl			; check if it was '\0'
	jz		.ret
	inc		rdi 			; ++dest
	inc		rsi 			; ++src
	jmp		.loop

.ret:
	pop		rsi
	pop		rdi
	ret		; return pointer to dest