; Assemble with
; $ nasm -f elf64 lab.asm
; Link with
; $ gcc lab.o -no-pie -o lab_executable

extern printf

global main

section .bss
input1  resb    0xff
input2  resb    0xff
output  resb    0xff
paramA  resq    1
paramB  resq    1
result  resq    1

section .data
fmt:    db      "%lld", 10, 0

section .text
; Converts string (e.g. result of sys_read) to integer
; Input:
; rdx = pointer to string to convert
; Output:
; rax = converted integer
_atoi:  xor     rax, rax
        xor     rbx, rbx
.nxtch: movzx   rcx, byte [rdx]
        inc     rdx
        cmp     rcx, '-'
        je      .sign
        cmp     rcx, '0'
        jb      .done
        cmp     rcx, '9'
        ja      .done
        sub     rcx, '0'
        imul    rax, 10
        add     rax, rcx
        jmp     .nxtch
.sign:  mov     rbx, 1
        jmp     .nxtch
.done:  cmp     rbx, 0
        je      .return
        neg     rax
.return ret

; Reads up to 0xff symbols from stdin
; Input:
; rsi = pointer to buffer to write to
_input: mov     rax, 0
        mov     rdi, 0
        mov     rdx, 0xff
        syscall
        ret

; Calls printf() function to write an integer
; Input:
; rax = integer to write
_prntf: mov     rdi, fmt
        mov     rsi, rax
        call    printf
        ret

; Calculates the power of a number
; Input:
; rax = base
; rcx = exponent
; Output:
; rdx:rax = calculated power
_pow:   mov     rbx, rax
        mov     rax, 1
        xor     rdx, rdx
.again: cmp     rcx, 0
        jle     .powed
        imul    rbx
        dec     rcx
        jmp     short .again
.powed: ret

main:   mov     rsi, input1
        call    _input
        mov     rdx, input1
        call    _atoi
        mov     [paramA], rax
        mov     rsi, input2
        call    _input
        mov     rdx, input2
        call    _atoi
        mov     [paramB], rax
        mov     rax, [paramA]
        call    _prntf
        mov     rax, [paramB]
        call    _prntf

; Task 11       (X+Y)/(X-Y)
        add     rax, [paramA]
        mov     rbx, [paramA]
        sub     rbx, [paramB]
        xor     rdx, rdx
        cqo
        idiv    rbx
        call    _prntf
; Task 12       (-X)^3 + 3
        mov     rax, [paramA]
        neg     rax
        mov     rcx, 3
        call    _pow
        add     rax, 3
        call    _prntf
; Task 13       X-Y/X+1
        mov     rax, [paramB]
        cqo
        idiv    qword [paramA]
        neg     rax
        inc     rax
        add     rax, [paramA]
        call    _prntf
; Task 14       ((X+Y)/Y^2-1)*X
        mov     rax, [paramB]
        mov     rcx, 2
        call    _pow         
        mov     rbx, rax     
        mov     rax, [paramA]
        add     rax, [paramB]
        xor     rdx, rdx
        cqo
        idiv    rbx
        dec     rax
        xor     rdx, rdx
        cqo
        imul    qword [paramA]
        call    _prntf
; Task 15       (X-Y)%(XY+1)
        mov     rax, [paramA]
        imul    qword [paramB]
        inc     rax
        mov     rbx, rax
        mov     rax, [paramA]
        sub     rax, [paramB]
        xor     rdx, rdx
        cqo
        idiv    rbx
        mov     rax, rdx
        call    _prntf
; End
        mov rax, 60
        mov rdi, 0
        syscall
