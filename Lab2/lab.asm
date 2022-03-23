global  var11

section .bss
x       resq    1
a       resq    1   
y1      resq    1
y2      resq    1
y       resq    1

section .data
half:    dq      -0.5
zero:    dq      0

section .text
var11:  movq    qword[x], xmm0
        movq    qword[a], xmm1
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
less:   fld     qword[x]
        fabs
        fadd    qword[a]
        fstp    qword[y1]
y1out:  movq    xmm0, qword[y1]
        
        finit
        fld     qword[y1]      
        fld     qword[y2]      
        fdiv                   
        fld     qword[half]    
        fadd                   
        frndint                
        fld     qword[y2]
        fmul
        fld     qword[y1]      
        fxch                   
        fsub                   
        fld     qword[zero]
        fcom
        fstsw   ax
        sahf
        fxch
        jbe     yout
        fld     qword[y2]
        fabs
        fadd
yout:   fstp    qword[y]
        movq    xmm0, qword[y]
ret
