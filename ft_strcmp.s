;	int		ft_strcmp(const char *s1, const char *s2); s1 == rdi, s2 = rsi

global _ft_strcmp
section .text

_ft_strcmp:
	push	rdx				; save register used by the func
	push	rdi				; save pointers given as args
	push	rsi
	xor		rax, rax		; initialize registers with 0
	xor		rdx, rdx
;	test	rdi, rdi		; uncomment to avoid segfault which strcmp has when one of the arg == NULL
;	jz		.ret
;	test	rsi, rsi
;	jz		.ret

.loop:
	mov		al, byte [rdi]	; put *s1 to al
	mov		dl, byte [rsi]	; put *s2 to dl
	sub		rax, rdx		; *s1 - *s2
	jnz		.ret
	test	dl, dl			; check if it was '\0' of one of the strings
	jz		.ret
	inc		rdi				; ++s1
	inc		rsi				; ++s2
	jmp		.loop

.ret:
	pop		rsi
	pop		rdi
	pop		rdx
	ret		; rax = s1 - s2
