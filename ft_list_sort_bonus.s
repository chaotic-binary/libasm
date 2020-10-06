;	void	ft_list_sort(t_list **begin_list, int (*cmp)());
;	rdi = **begin_list, rsi = *cmp

section .text
global _ft_list_sort

_ft_list_sort:
	push	rsi				; save cmp
	push	rdi				; save begin_list
	push	r8				; save registers used by this func
	push	r9
	push	r10
	push	r11
	test	rdi, rdi		; check if begin_list = NULL
	jz		.ret
	test	rsi, rsi		; check if there is cmp function
	jz		.ret
	mov		r10, [rdi]		; tmp = *begin_list
	test	r10, r10
	jz		.ret
	mov		r9, rdi			; r9 = begin_list
	mov		r8, rsi			; *cmp
	xor		rax, rax

.loop:
	mov		r11, [r10+8]	; r11 = tmp->next
	test	r11, r11		; check if tmp->next == NULL
	jz		.ret
	mov		rsi, [r11]		; rsi = tmp->next->data
	mov		rdi, [r10]		; rdi = tmp->data
	call	r8				; *cmp(rdi = tmp->data, rsi = tmp->next->data)
	test	rax, rax
	jg		.swap			; swap if cmp ret > 0
	jmp		.next			; else

.next:
	mov		r10, [r10+8]	; tmp = tmp->next
	jmp		.loop

.swap:
	mov		rdi, r10
	mov		rsi, r11
	call	_list_swap		; void	list_swap(t_list *lst1 = rdi, t_list *lst2 = rsi);
	mov		r10, [r9]		; return to the 1st elem (*begin_list)
	jmp		.loop

.ret:
	pop		r11				; restore registers used by this func
	pop		r10
	pop		r9
	pop		r8
	pop		rdi				; restore begin_list
	pop		rsi				; restore cmp
	ret

_list_swap
	push	r8				; save registers used by this func
	push	r9
	mov		r8, [rsi]		; r8 = tmp->next->data
	mov		r9, [rdi]		; r9 = tmp->data
	mov		[rdi], r8		; tmp->data = tmp->next->data
	mov		[rsi], r9		; tmp->next->data = tmp->data
	pop		r9				; restore registers used by this func
	pop		r8
	ret