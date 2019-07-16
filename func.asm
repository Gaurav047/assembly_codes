%include "io.mac"

segment .text
	global pal
pal:
	mov EBP, ESP
	;enter 0,0
	mov EAX, [EBP+4]		;EAX = size
	mov EBX, [EBP+8]		;EBX = strAdd
	mov EDX, EBX
	mov DI, [EAX]
	add DI,-2
	mov SI, 0
	movzx EDI, DI
	add EDX, EDI
	nwln

AGAIN:
	mov CL, [EBX]
	mov CH, [EDX]
	cmp CL,CH
	jne NEQ

	add EBX, 1
	add EDX, -1
	add DI, -1
	add SI, 1

	cmp SI, DI
	jl AGAIN

	cmp DI, SI
	je EQ

EQ:
	mov CX, 1
	jmp GOBACK

NEQ:
	mov CX, 0

GOBACK:
	;leave
ret
