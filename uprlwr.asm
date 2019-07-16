%include "io.mac"

.DATA
  name_prompt db "Please Type Your Name: ",0
  out_msg db "Your name in capitals is: ",0

.UDATA
  in_name resb 31

.CODE
  .STARTUP
  PutStr name_prompt
  GetStr in_name,31

  PutStr out_msg
  mov EBX,in_name

process_char:
  mov AL,[EBX]
  cmp AL,0
  je done
  cmp AL,'a'
  jl not_lower_case
  cmp AL,'z'
  jg not_lower_case

lower_case:
  add AL,'A'-'a'

not_lower_case:
  PutCh AL
  inc EBX
  jmp process_char

done:
  nwln
  .EXIT
