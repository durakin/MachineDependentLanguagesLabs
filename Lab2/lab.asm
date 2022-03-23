global  var11

section .bss
x       resq    1
a       resq    1   
y1      resq    1
y2      resq    1

;section .data

section .text
var11:  movq    qword[x], xmm0
        movq    qword[a], xmm1
        mov     rax, __float64__(4.0)   
        movq    xmm1, rax               
        ucomisd xmm0, xmm1              
        jbe     less1                   
        mov     rax, __float64__(2.0)   
        movq    xmm0, rax               
less1:  movq    [y2], xmm0
        
        movq    xmm0, qword[x]
        mov     rax, __float64__(1.0)   
        movq    xmm1, rax               
        ucomisd xmm0, xmm1              
        jbe     less2
        mov     rax, __float64__(10.0)  
        movq    xmm1, rax               
        addsd   xmm0, xmm1
        movq    [y1], xmm0
        jmp     y1out
less2:  fld     qword[x]
        fabs
        fadd    qword[a]
        fstp    qword[y1]
y1out:  movq    xmm0, qword[y1]
        
ret
