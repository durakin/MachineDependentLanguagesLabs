global _start

section .data
msg     db      'Hello, World!', 10

section .text
_start: mov     edx, 13
        mov     ecx, msg
        mov     ebx, 1
        mov     eax, 4
        int	0x80
        mov	eax,1
        int	0x80
