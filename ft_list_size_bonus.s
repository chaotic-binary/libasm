;	int		ft_list_size(t_list *begin_list); begin_list = rdi

global _ft_list_size
section .text

_ft_list_size:
	push	rdi				; save pointer to begin_list
	xor		rax, rax		; initialize register with 0

.loop:
	test	rdi, rdi		; check if begin_list == NULL
	jz		.ret
	inc		rax				; ++counter
	mov		rdi, [rdi+8]	; begin_list = begin_list->next
	jmp		.loop

.ret:
	pop		rdi				; restore register value
	ret						; return value of counter