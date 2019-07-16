%include "io.mac"

.DATA
prompt1 db "Enter the number to be multiplied: ",0
out_msg db "The number multiplied by 16 equals : ",0

.UDATA
inp_no resb 31

%macro mul_by_16 1
  sal %1,4
%endmacro

.CODE
  .STARTUP
  PutStr prompt1
  GetLInt EAX

  ;mul_by_16 EAX

  mov [inp_no],EAX

  PutStr out_msg
  PutLInt inp_no
  .EXIT
