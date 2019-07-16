section .data
  prompt: db "Enter the string : "
  size_pr: equ $-prompt
  ans1: db " is palindrome "
  size1: equ $-ans1
  ans2: db " is not palindrome "
  size2: equ $-ans2


section .bss
  string: resb 50
  temp: resb 1
  len:  resb 1
  j: resb 1
  i: resb 1


section .text
  global _start

_start:
 extern pal_check
  mov eax, 4          ;WRITING MODE
  mov ebx, 1
  mov ecx, prompt
  mov edx, size_pr
  int 80h             ;system call

  mov ebx, string      ;ebx has the base address of string
  mov byte[len], 0     ;storing 0 in len

reading:
  push ebx              ;base address of the string is pushed

  mov eax, 3
  mov ebx, 0
  mov ecx, temp         ;READ MODE
  mov edx, 1
  int 80h               ; system call

  pop ebx               ;ebx is popped
  mov al, byte[temp]    ;AL gets the byte stored in temp
  mov byte[ebx], al     ;ebx now gets the byte given earlier to AL

  inc byte[len]         ;value of len is incremented by one
  inc ebx               ;ebx now points to the next address of string

                        ;NASM changed the ascii code of enter 13 to 10
  cmp byte[temp], 10     ; If enter is pressed then it's ASCII value(10) is compared
  jne reading


endreading:
  dec ebx           ;ebx points to last character
  mov byte[ebx],0   ;End of string
  dec byte[len]     ;Length is decreased by one to remove the sentinal count




                      ;Printing the string....
  mov eax, 4
  mov ebx, 1
  mov ecx, string
  movzx edx, byte[len]    ;length of string
  int 80h

  mov byte[i], 0      ;i initialised to 0
  mov al, byte[len]   ;al gets the value of len(length of input string)
  mov byte[j], al     ;j = length of input string
  sub byte[j], 1      ; j--

  call pal_check;
