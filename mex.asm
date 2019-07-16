%include "io.mac"

.DATA
pr db "Enter the values: ",0
outd db "The exchanged values are: ",0

.UDATA
val1 resb 2
val2 resb 2

.CODE
  .STARTUP
  PutStr pr
  GetInt DX
  mov [val1],DX
  GetInt DX
  mov [val2],DX

  ;mxchg val2,val1

  PutStr outd
  PutInt val1
  nwln
  PutInt val2
  nwln
  .EXIT
