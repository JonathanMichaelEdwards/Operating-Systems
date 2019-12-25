; Compile and run:
;       nasm bootPrintChar.asm -f bin -o bootPrintChar.bin && qemu-system-i386 bootPrintChar.bin
; Hex dump output: 
;       od -t x1 -A n bootPrintChar.bin


;
; A simple boot sector that prints a message to the screen using a BIOS routine.
;
mov     ah,     0x0E     ; indicate tele-type (tty) mode

mov     al,     'H'
int     0x10
mov     al,     'e'
int     0x10
mov     al,     'l'
int     0x10
int     0x10
mov     al,     'o'
int     0x10

jmp $    ; jump to current address = infinite loop

;
; Padding and magic BIOS number.
;
times 510 -($-$$) db 0
dw 0xAA55              
   
