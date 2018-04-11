.section .data
iostring:
.asciz "ab1g2hA0H56po9wK78nB"
.section .text
.globl _start
_start:
    movl $iostring, %ebx
L1:
    movb (%ebx), %al
    test %al, %al
    je L3
    cmp $97, %al
    jb L2
    cmp $122, %al 
    ja L2
    sub $32, %al
    movb %al, (%ebx)
L2:
    inc %ebx
    jmp L1
#output
L3:
    movl $4, %eax
    movl $iostring, %ecx
    sub %ecx, %ebx
    movl %ebx, %edx
    movl $1, %ebx
    int $0x80
#exit
    movl $1, %eax
    movl $0, %ebx
    int $0x80
