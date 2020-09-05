;	int			ft_atoi_base(rdi = char *str, rsi = int base);

section .text
	global _ft_atoi_base

_ft_atoi_base:
;	push	r8
	cmp		rsi, 2			; base is in range 2 - 16
	jl		.ret_zero
	cmp		rsi, 16
	jg		.ret_zero
	mov		r8, 1			; sign = 1

.while_space:
	push	rdi
	mov		dil, [rdi]		; pass *str as arg
	call	_if_space
	pop		rdi
	test	rax, rax
	jz		.if_plus
	inc		rdi				; str++
	jmp		.while_space

.if_plus:
	mov		dl, byte[rdi]	; dl = *str
	cmp		dl, 43			; if *str == '+'
	jne		.if_minus
	inc		rdi				; str++
	jmp		.while_digit

.if_minus:
	cmp		dl, 45			; if *str == '-'
	jne		.while_digit
	neg		r8				; sign = -1
	inc		rdi				; str++

.while_digit:


;	mov rax, 2
;	imul rax, r8
;	ret

;.is_lowcase

;.is_upcase

.ret_zero:
;	pop		r8
	xor		rax, rax
	ret

_if_space:
	cmp		dil, 9			; if *str == '\t'
	je		.is_space
	cmp		dil, 10			; if *str == '\n'
	je		.is_space
	cmp		dil, 11			; if *str == '\r'
	je		.is_space
	cmp		dil, 12			; if *str == 'v'
	je		.is_space
	cmp		dil, 13			; if *str == '\f'
	je		.is_space
	cmp		dil, 32			; if *str == ' '
	je		.is_space
	xor		rax, rax		; return 0
	ret

.is_space:
	mov		rax, 1			; return 1
	ret