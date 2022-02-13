global _start

section .bss
input   resb    0xff                ; input length
output  resb    0xff
result  resd    1

section .text
; Converts string (e.g. result of sys_read) to integer
; Input:
; rdx = pointer to string to convert
; Output:
; rax = converted integer
_atoi:  mov     rdx, input          
        xor     rax, rax            ; zero a "result so far"
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
.done:  mov     [result], rax
        ret

; Reads up to 0xff symbols from stdin
; Input:
; rsi = pointer to buffer to write to
_input: mov     rax, 0
        mov     rdi, 0
        mov     rsi, input
        mov     rdx, 0xff           ; some length
        syscall
        ret

; Writes up to 0xff symbols to stdout
; Input:
; rso = pointer to buffer to read from
_print: mov     rax, 1
        mov     rdi, 1
        mov     rsi, output
        mov     rdx, 0xff           ; some length
        syscall
        ret

; Converts integer to string (e.g. for sys_write input) 
; Input:
; eax = integer value to convert
; esi = pointer to buffer to store the string in (must have room for at least 10 bytes)
; Output:
; eax = pointer to the first character of the generated string
; ecx = length of the generated string
_itoa:  mov     rax, [result]
        mov     rsi, output
        add     rsi, 255
        mov     byte [rsi], 0       ; string terminator
        mov     rbx, 10
.nxtdg: xor     rdx, rdx
        div     rbx                 ; eax /= 10
        add     dl, '0'             ; Convert the remainder to ASCII 
        dec     rsi                 ; store characters in reverse order
        mov     [rsi], dl
        test    rax, rax            
        jnz     .nxtdg              ; until eax==0
        
        mov rax, rsi
        ret

_start: call    _input
        call    _atoi
        inc     dword [result]
        call    _itoa
        call    _print
        mov rax, 60
        mov rdi, 0
        syscall
