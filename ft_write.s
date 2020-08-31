;	ssize_t	ft_write(int fd, const char *buf, size_t count);
;	fd = rdi, buf = rsi, count = rdx

global	_ft_write
extern ___error ; for errno
section	.text

_ft_write:
	mov		rax, 0x2000004	; put the write-system-call-code into register rax
	syscall
	jc		_error 			; if flags carry is set to 1 by write because of error
	ret

_error:
	push	rax				; save syscall result (error num)
	call	___error		; rax = &errno
	pop		rdx				; load error num to rdx
	mov		[rax], rdx		; *errno = error num
	mov		rax, -1 		; return -1
	ret