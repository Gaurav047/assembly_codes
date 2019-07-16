%include "io.mac"

.DATA
  number_prompt db "Please Enter the number ( < 11 digits ): ",0
  out_msg db "The sum of digits of the number is: ",0

.UDATA
  number resb 11

.CODE
  .STARTUP
  PutStr number_prompt
  GetStr number,11

  mov EBX,number
  sub DX,DX

repeat_add:
  mov AL,[EBX]
  cmp Al,0
  je done
  and AL,0FH
  add DL,AL         ;DX=0 and DL keeps the sum
  inc EBX
  jmp repeat_add

done:
  PutStr out_msg
  PutInt DX
  nwln
  .EXIT
