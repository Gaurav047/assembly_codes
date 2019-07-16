segment .text
	global showStack
showStack:
	enter 0,0
	mov EAX, [EBP+8]
	mov ECX, EAX
	mov AX, 4
	inc ECX			;4i
	imul CX
	movzx ECX, AX
	add EBP,ECX
	mov EAX,[EBP]
	sub EBP, ECX
	leave
ret




