global  main

section .bss
string  resb    0xff
n       resq    1

section .text

; Reads up to 0xff symbols from stdin
; Input:
; rsi = pointer to buffer to write to
_input: mov     rax, 0
        mov     rdi, 0
        mov     rdx, 0xff
        syscall
        ret

; Writes symbols from string to stdout
; Input:
; rsi = pointer to buffer to read from
; rdx = number of symbols to print
_output:mov     rax, 1
        mov     rdi, 1
        syscall
        ret

main:   mov     rsi, string
        call    _input
        mov     [n], rax
        xor     rdi, rdi
        mov     rdi, string
        mov     rcx, [n]
        mov     al, ' '
        cld
        repnz   scasb
        mov     rdx, rcx
        mov     rsi, rdi

        call    _output
        
        mov rax, 60
        mov rdi, 0
        syscall