extern printf

global  main

section .bss
string  resb    0xff
n       resq    1
array   resq    0

section .data
fmt:    db      "%lld", 10, 0

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
        ;mov     rdx, 0xff           ; some length
        syscall
        ret

; Calls printf() function to write an integer
; Input:
; rax = integer to write
_prntf: mov     rdi, fmt
        mov     rsi, rax
        call    printf
        ret


main:   mov     rsi, string
        call    _input
        ;dec     rax
        mov     [n], rax
        ;call    _prntf

        xor     rdi, rdi

        mov     rdi, string
        mov     rcx, [n]
        mov     al, ' '
        cld
        repnz   scasb
        ;dec     rsi
        cmp     rcx, 0
        jne     .found
        mov     rdi, string
        mov     rdx, [n]
        jmp     .result

.found: mov     rdx, rcx
        mov     rsi, rdi

.result:call    _output
        
        mov rax, 60
        mov rdi, 0
        syscall