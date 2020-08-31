;	void		ft_list_push_front(t_list **begin_list, void *data); **begin_list = rdi, *data = rsi

section .text
	global _ft_list_push_front
	extern _malloc

_ft_list_push_front:
	test	rdi, rdi 			; check if begin_list == NULL
	jz		.ret
	push	rdi					; save pointer to begin_list
	mov		rdi, rsi 			; put data to rdi
	call	_ft_create_elem
	test	rax, rax			; malloc protection (malloc puts pointer to the new block of memory in rax)
	jz		_malloc_error
	pop		rdi					; load pointer to rdi
	mov		rsi, qword [rdi]
	mov		qword [rax+8], rsi	; new->next = *begin_list
	mov		qword [rdi], rax	; *begin->list = new

.ret:
	ret

;	t_list	*ft_create_elem(void *data) data = rdi
_ft_create_elem:
	push	rdi					; save pointer to data
	mov		rdi, 16 			; sizeof(t_list) = 8 bytes for the pointer to begin_list + 8 bytes for the pointer next
	call	_malloc				; t_list *elem; elem = malloc(sizeof(t_list));
	test	rax, rax			; malloc protection (malloc puts pointer to the new block of memory in rax)
	jz		_malloc_error
	pop		qword [rax]			; elem->data = data;
	mov		qword [rax+8], 0x0	; elem->next = NULL
	ret

_malloc_error:
	pop		rdi		; load pointer back to rdi
	ret				; return 0