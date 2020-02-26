org 0x7c00			; BIOS loads at this address
bits 16				; use 16 bits

	
boot:
	mov dl, 40
	mov dh, 12
	mov ah, 2
	mov bh, 0
	int 10h

	mov si, msg
	mov ah, 0x0e

.loop:
	lodsb
	or al, al
	jz halt
	int 0x10
	jmp .loop

halt:
	cli
	hlt


msg db "Hello World", 0

