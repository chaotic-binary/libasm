;	void	ft_list_remove_if(rdi = t_list **begin_list, rsi = void *data_ref, rdx = int (*cmp)(), rcx = void (*free_fct)(data));

section	.text
global	_ft_list_remove_if
extern	_free

_ft_list_remove_if:
	test	rdi, rdi			; check if agrs == NULL
	jz		ret
	test	rdx, rdx
	jz		ret
	test	rcx, rcx
	jz		ret
