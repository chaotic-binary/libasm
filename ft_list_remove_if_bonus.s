;	void	ft_list_remove_if(rdi = t_list **begin_list, rsi = void *data_ref, rdx = int (*cmp)());

section	.text
global	_ft_list_remove_if
extern	_free

_ft_list_remove_if:
	test	rdi, rdi		; check if agrs == NULL
	jz		.ret
	test	rdx, rdx
	jz		.ret
;	push	r10
;	push	r11

.loop_begin:
	mov		r10, [rdi]		; r10 = *begin_list
	test	r10, r10		; check if *begin_list == NULL
	jz		.loop_mid
	push	rdi				; save args
	push	rsi
	mov		rdi, [r10]		; rdi = *begin_list->data
	call	rdx				; *cmp(rdi=(*begin_list)->data, rsi=data_ref)
	pop		rsi
	pop		rdi
	test	rax, rax		; check cmp ret
	jnz		.loop_mid
	mov		r10, [rdi]
	mov		r11, [r10+8]	; r11 = *begin_list->next
	mov		[rdi], r11		; *begin_list = (*begin_list)->next
	push	rdi
	push	rsi
	push	rdx
	push	r10
	push	r11
	mov		rdi, r10		; rdi = *begin_list
	call	_free			; free(rdi=*begin_list)
	pop		r11
	pop		r10
	pop		rdx
	pop		rsi
	pop		rdi
	jmp		.loop_begin

.loop_mid:
	test	r10, r10		; check if r10 == NULL
	jz		.ret
	mov		r11, [r10+8]	; r11 = r10->next
	test	r11, r11		; check if tmp->next == NULL
	jz		.ret
	push	rdi
	push	rsi
	mov		rdi, [r11]		; rdi = tmp->next->data
	call	rdx				; *cmp(rdi=(*being_list)->data, rsi=data_ref)
	pop		rsi
	pop		rdi
	test	rax, rax		; check cmp ret
	jnz		.next
	push	rdi
	push	rsi
	push	rdx
	push	r10
	push	r11
	mov		rdi, r11		; rdi = tmp->next
	mov		r11, [r11+8]	; r11 = tmp->next->next
	mov		[r10+8], r11	; r10->next = tmp->next->next
	call	_free			; free(rdi=tmp->next)
	pop		r11
	pop		r10
	pop		rdx
	pop		rsi
	pop		rdi
	jmp		.loop_mid

.next:
	mov		r10, r11		; r10 = tmp->next
	jmp		.loop_mid

.ret:
;	pop		r11
;	pop		r10
	ret
