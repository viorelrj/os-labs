org 0x7c00; BIOS loads at this address

bits 16; use 16 bits

start:
	cli			;disable interrupts

	mov si, msg		;SI points to message
	mov ah, 0x0e		;Print char service

.loop	lodsb
	or al, al		;Is end of string?
	jz halt
	int 0x10		;print char
	jmp .loop		;next char

halt: 	hlt

msg: 	db "Hello, World!", 0
