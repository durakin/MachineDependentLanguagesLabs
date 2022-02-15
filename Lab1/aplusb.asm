global _start

section .bss
input1  resb    0xff
input2  resb    0xff
output  resb    0xff
paramA  resq    1
paramB  resq    1
result  resq    1

section .text
; Converts string (e.g. result of sys_read) to integer
; Input:
; rdx = pointer to string to convert
; Output:
; rax = converted integer
_atoi:  xor     rax, rax            ; zero a "result so far"
.nxtch: movzx   rcx, byte [rdx]     ; get a character
        inc     rdx                 ; ready for next one
        cmp     rcx, '0'            ; valid?
        jb      .done               ;
        cmp     rcx, '9'            ; valid?
        ja      .done               ;
        sub     rcx, '0'            ; "convert" character to number
        imul    rax, 10             ; multiply "result so far" by ten
        add     rax, rcx            ; add to result
        jmp     .nxtch              ; until done
.done:  ret

; Reads up to 0xff symbols from stdin
; Input:
; rsi = pointer to buffer to write to
_input: mov     rax, 0
        mov     rdi, 0
        mov     rdx, 0xff           ; some length
        syscall
        ret

; Writes up to 0xff symbols to stdout
; Input:
; rsi = pointer to buffer to read from
_print: mov     rax, 1
        mov     rdi, 1
        ;mov     rdx, 0xff           ; some length
        syscall
        ret

; Converts integer to string (e.g. for sys_write input) 
; Input:
; rax = integer value to convert
; rsi = pointer to buffer to store the string in
; Output:
; rax = pointer to the first character of the generated string
; rcx = length of the generated string
_itoa:  add     rsi, 240
        mov     byte [rsi], 0       ; string terminator
        mov     rbx, 10
        xor     rcx, rcx
.nxtdg: xor     rdx, rdx
        div     rbx                 ; rax /= 10
        add     dl, '0'             ; Convert the remainder to ASCII 
        dec     rsi                 ; store characters in reverse order
        mov     [rsi], dl
        inc     rcx
        test    rax, rax
        jnz     .nxtdg              ; until rax==0
        mov     rax, rsi
        ret

_start: mov     rsi, input1
        call    _input
        mov     rdx, input1
        call    _atoi
        mov     [paramA], rax
        mov     rsi, input2
        call    _input
        mov     rdx, input2
        call    _atoi
        mov     [paramB], rax

        sub     rax, [paramA]

        mov     rsi, output
        call    _itoa
        mov     rdx, rcx
        mov     rsi, rax
        call    _print
        mov rax, 60
        mov rdi, 0
        syscall
