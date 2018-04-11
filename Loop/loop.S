#loop1.S
.section .data
  bytevar:
	.rept	10
  	.byte 	0
  	.endr
  	.byte 	13, 10
.section .text
.globl _start
_start:
  mov 	$10, %ecx
  mov 	$0x30, %al
  mov 	$bytevar, %ebx
L1:
  movb 	%al, (%ebx)
  inc  	%ebx
  inc  	%al
  loop 	L1

#output
  mov   $4, %eax
  mov   $1, %ebx
  mov   $bytevar, %ecx
  mov   $12, %edx
  int   $0x80

#exit
  movl  $1, %eax
  movl  $0, %ebx
  int   $0x80
