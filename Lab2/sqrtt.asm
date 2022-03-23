global sqrtt

section .bss
	res: resq 1      ; reserve 1 quadword for result
    inp: resq 1

section .text

sqrtt:
	MOVQ 	qword [inp], xmm0
	fld 	qword [inp]
	; load value into st(0)
	fsqrt
	; store st(0) at res, and pop it off the x87 stack
	fstp    qword [res]
	; the FPU stack is now empty again
    movsd   xmm0, qword [res]
    ret
	; end of program