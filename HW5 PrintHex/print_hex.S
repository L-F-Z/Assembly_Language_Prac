.section .text
.globl print_hex
.type print_hex, @function
print_hex:
  push  %ebp
  mov   %esp, %ebp
  sub   $16, %esp
  mov   %ebx, 12(%esp) # save ebx
  movb  $0, 11(%esp)   # buf[11] = \0
  lea   10(%esp), %eax # eax = buf + 10
  movl  24(%esp), %ecx # ecx = var
  movl  %ecx, %ebx     # ebx = var
  test  %ecx, %ecx
  jz    Zero
  js    Negative
L1:
  mov   %ecx, %edx
  andb  $0xf, %dl
  cmpb  $10, %dl
  jb    L2
  addb  $0x57, %dl
  jmp   L3
L2:
  orb   $0x30, %dl
L3:
  movb  %dl, (%eax)
  dec   %eax
  shrl  $4, %ecx
  test  %ecx, %ecx
  jnz   L1

  movb  $'x', (%eax)
  dec   %eax
  movb  $'0', (%eax)
  dec   %eax
  test  %ebx, %ebx
  js    AddSign
Print:
  mov   %eax, %ecx
  lea   11(%esp), %edx
  sub   %eax, %edx
  mov   $4, %eax
  mov   $1, %ebx
  int   $0x80
  mov   12(%esp), %ebx # load old ebx
  leave
  ret
AddSign:
  movb  $'-', (%eax)
  dec   %eax
  jmp   Print
Negative:
  neg   %ecx           # ecx = -ecx
  jmp   L1
Zero:
  movb  $'0', (%eax)
  dec   %eax
  movb  $'x', (%eax)
  dec   %eax
  movb  $'0', (%eax)
  dec   %eax
  jmp   Print
  