; ; Compile and run:
; ;       nasm bootPrintString.asm -f bin -o bootPrintString.bin && qemu-system-i386 bootPrintString.bin
; ; Machine code output: 
; ;       od -t x1 -A n bootPrintString.bin
 
; ; A boot sector that prints a string using our function.
; ;
; mov ah, 0x0e
; [org 0x7c00]    ; Tell the assembler where this code will be loaded

;     mov al, 'A'
;     call HELLO_MSG
;     int 0x10

;     ; Use BX as a parameter to our function , so
;     ; we can specify the address of a string.
;     ; mov bx, GOODBYE_MSG
;     ; call GOODBYE_MSG

; jmp $    ; Hang

; %include "printMessage.asm"



; ; Padding and magic number.
; times 510 -($-$$) db 0
; dw 0xaa55


[bits 16]           ; tell assembler that working in real mode(16 bit mode)
[org 0x7c00]        ; organize from 0x7C00 memory location where BIOS will load us


start:              ; start label from where our code starts


	xor ax,ax           ; set ax register to 0
	mov ds,ax           ; set data segment(ds) to 0
	mov es,ax           ; set extra segment(es) to 0
	mov bx,0x8000


	mov si, hello_world              ; point hello_world to source index
	call print_string				       ; call print different color string function



	hello_world db  'Hello World!',13,0


print_string:
	mov ah, 0x0E            ; value to tell interrupt handler that take value from al & print it

.repeat_next_char:
	lodsb   			 ; get character from string
	cmp al, 0             		 ; cmp al with end of string
	je .done_print		    	 ; if char is zero, end of string
	int 0x10                	 ; otherwise, print it
	jmp .repeat_next_char   	 ; jmp to .repeat_next_char if not 0

.done_print:
	ret                 	    ;return

	times (510 - ($ - $$)) db 0x00     ;set 512 bytes for boot sector which are necessary
	dw 0xAA55                           						   ; boot signature 0xAA & 0x55
	