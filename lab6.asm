;	Name : Gaurav Kumar    Roll no. B16057
;       Objective: To add two marices
;       Input: Requests two  integers  r and c, Request all the values
;       Output: Outputs the matrix Cij = Aij + Bij
%include "io.mac"

.DATA
msg_row  db   "Input the row size : ",0
msg_col  db   "Input the column size : ",0
msg_space db " ",0



.UDATA 
row    resw	1				
col    resw	1
mat1	resw	100
mat2	resw	100 
mat3	resw	100 
addA	resd    1
addB	resd    1
addC	resd    1
total resd 1
.CODE
      .STARTUP

	call acceptSize
	mov [row], BX
	mov [col], DX
	mov AX, [col]	
	mul BX			;mul abc will always multiply abc with ax and store in ax
	mov [total], EAX	;total has total number of elements	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	push total  			;push total value address
	push mat1 				;push address of matrix	1
	call acceptMat
	push word[row]
	push word[col]
	nwln
	call showMat
	pop CX 	
	pop CX
	pop ECX	

	push mat2
	nwln 				;push address of matrix	2
	call acceptMat
	push word[row]
	push word[col]
	nwln
	call showMat
	pop CX
	pop CX
	pop ECX

	push mat3
	push mat2
	push mat1
	call calcMat3
	pop ECX
	pop ECX
	push word[row]
	push word[col]
	nwln
	call showMat
	pop CX
	pop CX
	pop ECX
	pop ECX

done:
      .EXIT

acceptSize:
	PutStr msg_row
	GetInt BX
	PutStr msg_col
	GetInt DX
	ret

acceptMat:
	mov EBP, ESP
	mov EBX, [EBP+8]; EBX points to the location that has total number of numbers
	mov EDX, [EBP+4]	;EDX has the base address of matrix
	mov ECX, 0

	AGAIN1:
	GetInt [EDX]
	add EDX, 2
	ADD ECX, 1
	cmp ECX, [EBX] 
	jne AGAIN1
	ret


showMat:
	mov EBP, ESP
	mov EBX, [EBP+12]; EBX has total number of numbers
	mov EDX, [EBP+8]	;EDX has the base address of matrix
	mov ECX, 0
	mov SI, [EBP+4]   ;val of col
	mov DI, [EBP+6]	  ;val of row
	mov AX, 0

	loop41:
	nwln
	loop42:
	PutInt [EDX]
	PutStr msg_space
	ADD EDX,2
	ADD ECX, 1
	ADD AX,1
	cmp AX, SI		;SI stores the number of col
	jne loop42		;executes till AX != SI
	mov AX, 0
	cmp ECX, [EBX] 		;compares ECX and [EBX] i.e. total no. of elements of the Matrix
	jne loop41
	ret

calcMat3:
	mov EBP, ESP
				;[EBP+4] : address of mat1, [EBP+8], address of mat2, [EBP+12]:address of mat3, [EBP+16]:total size
	mov EBX, [EBP+16]	; EBX has total number of numbers
	mov EAX, [EBP+4]	;EAX has address of mat1
	mov [addA], EAX		;[addA] has the base address of mat1
	mov EAX, [EBP+8]	;EAX has address of mat2
	mov [addB], EAX		;[addB] has the base address of mat2
	mov EAX, [EBP+12]	;EAX has address of mat3
	mov [addC], EAX		;[addC] has the base address of mat3
	mov ECX, 0

	loop3:

	mov EAX, [addC]		;EAX has base address of mat3
	mov EDX, [addA]		;EDX has base address of mat1
	mov SI, [EDX]		;SI has the value at base address of mat1
	mov [EAX], SI		;EAX has value = SI
	add EDX, 2		;EDX now moves to address of next element.
	mov [addA], EDX		;addA stores the address of new EDX
	
	mov EDX, [addB]		;EDX stores the base address of mat2
	mov SI, [EDX]		;SI stores the new value at EDX's location
	add [EAX], SI		; value at EAX now becomes = [EAX] + SI
	add EDX, 2		;EDX stores the address of next element of mat2
	mov [addB], EDX		; addB stores the address of new EDX

	add EAX, 2		;EAX has the address of next element of mat3
	mov [addC], EAX		;addC stores the address of next element of mat3

	ADD ECX, 1		;ECX is the loop counter incremented by 1
	cmp ECX, [EBX] 		;if ECX == [EBX] , terminate
	jne loop3
	ret

