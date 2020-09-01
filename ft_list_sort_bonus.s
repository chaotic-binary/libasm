;	void	ft_list_sort(t_list **begin_list, int (*cmp)());

section .text
global _ft_list_sort

_ft_list_sort:
	test	rdi, rdi		; check if begin_list = NULL
	jz		.ret
	test	rsi, rsi		; ckeck if there is cmp function
	jz		.ret
	mov		rdx, rsi		; rdx =  *cmp
	mov		r10, [rdi]		; tmp = *begin_list
	push	rsi				; save cmp

.loop:
	mov		r11, [r10+8]	; r11 = tmp->next
	test	r11, r11		; check if tmp->next == NULL
	jz		.ret
	push	rdi				; save begin_list
	mov		rsi, [r11]		; rsi = tmp->next->data
	mov		rdi, [r10]		; rdi = tmp->data
	call	rdx				; *cmp(rdi = tmp->data, rsi = tmp->next->data)
	pop		rdi				; restore begin_list
	test	rax, rax
	jg		.swap			; swap if cmp ret > 0
	jmp		.next			; else

.swap:
	mov		r8, [r11]		; r8 = tmp->next->data
	mov		r9, [r10]		; r9 = tmp->data
	mov		[r10], r8		; tmp->data = tmp->next->data
	mov		[r11], r9		; tmp->next->data = tmp->data
	mov		r10, [rdi]		; return to the 1st elem (*begin_list)
	jmp		.loop

.next:
	mov		r10, [r10+8]	; tmp = tmp->next
	jmp		.loop

.ret:
	pop		rsi				; restore cmp
	ret