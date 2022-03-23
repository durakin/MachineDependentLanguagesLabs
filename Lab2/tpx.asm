global tpx

section .bss
yOne    resq    1
yTwo    resq    1

section .data
ten:    dq      14.88

section .text
tpx:    movsd     xmm1, [ten]
        addsd   xmm0, xmm1
        ret