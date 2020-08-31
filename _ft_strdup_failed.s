_ft_strdup:
			push	rdi					; save the pointer to s using rsp as the address
			call	_ft_strlen			; rax = strlen
			mov		rdi, rax			; rdi = rax = strlen
			inc		rdi					; + 1 for '\0'
			mov		rdi, rcx 			; store strlen + 1 in rcx
			call	_malloc				; malloc allocates memory for the string using length in rdi
			pop		rsi					; load saved pointer to s from the stack to rsi - second parameter for memcpy
			test	rax, rax			; malloc protection (malloc puts pointer to the new block of memory in rax)
			jz		.malloc_error
			mov		rdi, rax			; the result of malloc is in rdi - the first parameter for memcpy
	rep		movsb						; "memcpy", copy src to dest byte by byte rcx times
			pop rax
			ret

.malloc_error:
			ret	; return 0