global  var11

section .bss
x       resq    1
a       resq    1   
y1      resq    1
y2      resq    1
y       resq    1
result  resq    10

section .text
var11:  movq    qword[x], xmm0
        movq    qword[a], xmm1
        mov     rcx, 0
        mov     rbx, result
again:  movq    xmm0, qword[x]
        mov     rax, __float64__(4.0)   
        movq    xmm1, rax               
        ucomisd xmm0, xmm1              
        jbe     y2out                   
        mov     rax, __float64__(2.0)   
        movq    xmm0, rax               
y2out:  movq    [y2], xmm0
        movq    xmm0, qword[x]
        mov     rax, __float64__(1.0)   
        movq    xmm1, rax               
        ucomisd xmm0, xmm1              
        jbe     less
        mov     rax, __float64__(10.0)  
        movq    xmm1, rax               
        addsd   xmm0, xmm1
        movq    [y1], xmm0
        jmp     y1out
less:   finit
        fld     qword[x]
        fabs
        fadd    qword[a]
        fstp    qword[y1]
y1out:  movq    xmm0, qword[y1]                         
        finit           
        fld qword[y2]   
        fld qword[y1]
        fprem           
yout:   fstp    qword[y]
        movq    xmm0, qword[y]
        movq    [rbx], xmm0
        inc     rcx
        add     rbx, 8
        movq    xmm1, qword[x]
        mov     rax, __float64__(1.0)
        movq    xmm2, rax
        addsd   xmm1, xmm2
        movq    qword[x], xmm1
        cmp     rcx, 10
        jb      again
        mov     rax, result
ret
