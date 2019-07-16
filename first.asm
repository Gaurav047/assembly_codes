%include "io.mac"

.DATA
  input_prompt db "Please enter at most 10 numbers: ",0
  end_msg db "No more numbers? Enter 0 to end: ",0
  sum_msg db "The Sum is: ",0

.CODE
  .STARTUP
  PutStr input_prompt
  mov ECX,10
  sub EAX,EAX
  read_loop:
    GetLInt EDX
    cmp EDX,0
    je reading_done
    add EAX,EDX
    cmp ECX,1
    je skip_msg
    PutStr end_msg
  skip_msg:
    loop read_loop
  reading_done:
    PutStr sum_msg
    PutLInt EAX
    nwln
    .EXIT
