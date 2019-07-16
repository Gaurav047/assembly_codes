%include "io.mac"

.DATA
name_msg db 'PLease enter your name:  ',0
query_msg db 'How many times to repeat welcome message?',0
confirm_msg2 db ' times? (Y/n)',0
confirm_msg1 db 'Repeat welcome message',0
welcome_msg db 'Welcome to Assembly Language Programming ',0

.UDATA
user_name resb 16
response resb 1

.CODE
  .STARTUP
  PutStr name_msg
  GetStr user_name,16

ask_count:
  PutStr query_msg
  GetInt CX             ;CX is used as the loop counter in the io.mac macro file.
  PutStr confirm_msg1
  PutInt CX
  PutStr confirm_msg2
  GetCh [response]
  cmp byte [response],'Y'
  jne ask_count

display_msg:
  PutStr welcome_msg
  PutStr user_name
  nwln
  loop display_msg
  .EXIT
