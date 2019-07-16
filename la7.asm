;Name : Gaurav Kumar   Roll No. : B16057
;   Objective : To check if a string is a palindrome or not.
;   Input : A string
;   Output : Yes/No ( Yes - If it is a palindrome , No - If it is not a palindrome )
%include "io.mac"

.DATA
plen db "Enter the Size of the string :",0
prompt db "Enter the string to check if it is a palindrome or not : ",0
True db "YES",0
False db "No",0

.UDATA
Size resb 10
stri resb 20

.CODE
  .STARTUP
  extern pal
    call sizestr        ;Get the size of the string
    call acceptstr      ;Get the string

    push stri
    push Size
    call pal
    cmp CX,0
    je OUT1
    PutStr True
    jmp done

OUT1:
  PutStr False
done:
  .EXIT

sizestr:
  PutStr plen
  GetInt [Size]
  ret

acceptstr:
  PutStr prompt
  GetStr [stri],20
  ret
