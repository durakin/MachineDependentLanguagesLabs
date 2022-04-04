global  var11

section .bss
n       resq    1
row     resq    1
diagel  resq    1

section .text

var11:  mov     [n], rdi
        mov     rax, [n]
        mov     [row], rdx
        xor     rdx, rdx
        cqo
        imul    rax     
        mov     rax, [n]             
        inc     rax                  
        imul    qword[row]           
        mov     rbx, [rsi + rax * 8] 
        mov     [diagel], rbx        
        mov     rcx, 0               
newel:  mov     rax, [row]           
        imul    qword[n]             
        add     rax, rcx              
        mov     rbx, [diagel]        
        add     [rsi + rax * 8], rbx 
        inc     rcx                  
        cmp     rcx, [n]             
        jne     newel                   
        mov     rax, rsi
        ret
