;	int			ft_atoi_base(rdi = char *str, rsi = int base);

section .text
	global _ft_atoi_base

_ft_atoi_base:
;	push	r8
;	push	r9
	mov		r8, 1				; sign = 1
	xor		r9, r9				; nb = 0
	cmp		rsi, 2				; check if base is in range 2 - 16
	jl		.ret
	cmp		rsi, 16
	jg		.ret

.while_space:
	push	rdi
	push	rsi
	mov		dil, byte [rdi]		; pass *str as arg
	call	_if_space
	pop		rsi
	pop		rdi
	test	rax, rax
	jz		.if_plus
	inc		rdi					; str++
	jmp		.while_space

.if_plus:
	mov		dl, byte [rdi]		; dl = *str
	cmp		dl, 43				; if *str == '+'
	jne		.if_minus
	inc		rdi					; str++
	jmp		.while_digit

.if_minus:
	cmp		dl, 45				; if *str == '-'
	jne		.while_digit
	neg		r8					; sign = -1
	inc		rdi					; str++

.while_digit:
	push	rdi					; save rdi
	push	rsi					; save rsi
	xor		rax, rax
	mov		al, byte [rdi]
	xor		rdi, rdi
	mov		di, ax
	call	_get_digit
	pop		rsi					; restore rsi
	pop		rdi					; restore rdi
	cmp		rax, -1
	je		.ret
	imul	rax, r8
	imul	r9, rsi
	add		r9, rax
	inc		rdi
	jmp		.while_digit

.ret:
	mov		rax, r9
;	pop		r9
;	pop		r8
	ret

_if_space:
	cmp		dil, 9				; if *str == '\t'
	je		.is_space
	cmp		dil, 10				; if *str == '\n'
	je		.is_space
	cmp		dil, 11				; if *str == '\r'
	je		.is_space
	cmp		dil, 12				; if *str == 'v'
	je		.is_space
	cmp		dil, 13				; if *str == '\f'
	je		.is_space
	cmp		dil, 32				; if *str == ' '
	je		.is_space
	xor		rax, rax			; return 0
	ret

.is_space:
	mov		rax, 1				; return 1
	ret

_get_digit:

.is_digit:
	cmp		rdi, '0'
	jl		.invalid
	cmp		rdi, '9'
	jg		.is_upcase
	sub		rdi, 48				; *str - '0'
	cmp		rdi, rsi			; compare to base
	jl		.valid
	jmp		.invalid

.is_upcase:
	cmp		rdi, 'A'
	jl		.invalid
	cmp		rdi, 'F'
	jg		.is_lowcase
	sub		rdi, 55				; get num value of *str
	cmp		rdi, rsi			; compare to base
	jl		.valid
	jmp		.invalid

.is_lowcase:
	cmp		rdi, 'a'
	jl		.invalid
	cmp		rdi, 'f'
	jg		.invalid
	sub		rdi, 87
	cmp		rdi, rsi			; compare to base
	jl		.valid
	jmp		.invalid

.valid:
	mov		rax, rdi			; return digit (numerical value of *str)
	ret

.invalid:
	mov		rax, -1				; return -1
	ret
