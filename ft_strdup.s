;	char		*ft_strdup(const char *s); s = rdi

global _ft_strdup
section .text

extern _ft_strcpy
extern _ft_strlen
extern _malloc

_ft_strdup:
	push	rdi					; save the pointer to s using rsp as the address
	call	_ft_strlen			; rax = strlen
	mov		rdi, rax			; rdi = strlen = sizeof(s)
	inc		rdi					; + 1 for '\0'
	call	_malloc				; malloc allocates memory for the string using length in rdi
	test	rax, rax			; malloc protection (malloc puts pointer to the new block of memory in rax)
	jz		.malloc_error
	mov		rdi, rax			; the result of malloc is in rdi - the first parameter for strcpy
	pop		rsi					; load saved pointer to s from the stack to rsi - second parameter for strcpy
	call	_ft_strcpy			; strcpy fills dest and returns the pointer to it to rax.
	ret

.malloc_error:
	pop		rdi					; restore pointer to s
	ret							; return NULL
