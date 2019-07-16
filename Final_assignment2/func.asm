segment .text
      global pal_check
pal_check:
  mov eax, string        ;Base address of string is in eax
  mov ebx, string        ;Base address of string is in ebx
  movzx ecx, byte[i]     ;moving 8 byte to 32 byte register and storing value of i in ecx
  add eax, ecx           ;eax = eax + ecx  now eax points to end of the string
  movzx ecx, byte[j]     ;ecx = value of j
  add ebx, ecx           ;ebx = ebx + ecx
  mov cl, byte[eax]      ;cl = value of eax
  mov ch, byte[ebx]      ;ch = value of ebx
  cmp cl, ch             ;checking if end of the string and begining of the string are same
  jne not_pal            ;if not same then jump to not_pal

  inc byte[i]            ;if same then increase i by 1 and decrease j by 1
  dec byte[j]
  mov al, byte[i]
  mov ah, byte[j]
  cmp al,ah             ;if value of i is less than j then jump to pal_check
  jl pal_check


  mov eax, 4            ;if i greater than or equal to j then WRITING MODE
  mov ebx, 1
  mov ecx, ans1         ;Print ans1 Yes it is a palindrome
  mov edx, size1
  int 80h
  jmp exit              ;end the code

not_pal:
  mov eax, 4
  mov ebx, 1
  mov ecx, ans2         ;If not palindrome then print ans2 No it is not a palindrome
  mov edx, size2
  int 80h


exit:
  mov eax, 1            ;EXIT
  mov ebx, 0
  int 80h
