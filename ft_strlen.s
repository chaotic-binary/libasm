;	size_t	ft_strlen(const char *s); s = rdi

section .text
global _ft_strlen

_ft_strlen:
;		push	rdi				; save pointer to s
		xor		rcx, rcx 		; initialize register with 0
		lea		rcx, [rcx-1]	; rcx = -1 = max due to overflow
		xor		al, al			; zero byte (at the end of string) that scasb will be scanning for
		cld			; clear Direction Flag to make sure pointer will be incrementing while shifting, not decrementing
repne	scasb		; microprocessor decreased the value of rcx with every scan, including when it found the NUL. Thus, rcx = - strlen - 2
		not		rcx				; reversing all bits of a negative number results in its absolute value - 1
;		pop		rdi				; reverse push instruction
		lea		rax, [rcx-1]	; return (rcx - 1)
		ret