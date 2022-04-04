global  var11

section .bss
n       resq    1
array   resq    100
nsq     resq    1
row     resq    1
diagel  resq    1

section .text
;var11:  mov     [n], rdi
;        mov     rax, [n]
;        mov     [row], rdx
;        xor     rdx, rdx
;        cqo
;        imul    rax     
;        mov     [nsq], rax
;        mov     rcx, [nsq]
;        dec     rcx
;        
;lpstrt: mov     rbx, rsi
;        mov     rax, rcx
;        xor     rdx, rdx
;        cqo
;        imul    rax, 8
;        add     rbx, rax
;        mov     rax, [rbx]
;        mov     [array + rcx], rax
;        cmp     rcx, 0
;        je      lpfnsh
;        dec     rcx
;        jmp     lpstrt
;lpfnsh: mov     rax, array
;

var11:  mov     [n], rdi
        mov     rax, [n]
        mov     [row], rdx
        xor     rdx, rdx
        cqo
        imul    rax     
        mov     [nsq], rax
        mov     rcx, [nsq]
;       mov     rbx, rsi

        mov     rax, [n]                ; rax = n = 3
        inc     rax                     ; rax = 4
        imul    qword[row]              ; rax = 4 * 0 = 0
        mov     rbx, [rsi + rax * 8]    ; rbx = array[0] = 1
        mov     [diagel], rbx           ; diagel = 1
        mov     rcx, 0                  ; rcx = 0
newel:  mov     rax, [row]              ; rax = 0
        imul    qword[n]                ; rax = 0
        add     rax, rcx                ; rax = 0               ; rax += 1 = 1  ; rax = 
        mov     rbx, [diagel]           ; rbx = 1               
        add     [rsi + rax * 8], rbx    ; array[0] += 1         ; array[1] += 1
        inc     rcx                     ; rcx = 1               ; rcx = 2
        cmp     rcx, [n]                ; rcx ? 3               ; rcx ? 3
        jne     newel                   

        mov     rax, rsi
       ret
