.section .data
  var: .int 0x80001234
.section .text
.globl  _start
_start:
  pushl var
  call  print_hex
  mov   $1, %eax
  mov   $0, %ebx
  int   $0x80
  