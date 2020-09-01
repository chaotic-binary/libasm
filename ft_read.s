;	ssize_t	ft_read(int fd, void *buf, size_t count);
;	fd = rdi, buf = rsi, count = rdx

global	_ft_read
extern	___error ; for errno
section	.text

_ft_read:
	mov		rax, 0x2000003	; put the read-system-call-code into register rax
	syscall
	jc		_error			; if flags carry is set to 1 by read because of error
	ret

_error:
	push	rax				; save syscall result (error num)
	call	___error		; rax = &errno
	pop		rdx				; load error num to rdx
	mov		[rax], rdx		; *errno = error num
	mov		rax, -1 		; return -1
	ret