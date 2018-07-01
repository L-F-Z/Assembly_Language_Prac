.section .bss
    .lcomm str, 100
.section .text
.globl readint
.type  readint, @function
readint:
    mov $0, %rax
    mov $1, %rdi
    mov $str, %rsi
    mov $100, %rdx
    syscall
    mov $0, %rax
    mov $1, %rcx
    movb (%rsi), %bl
    cmp $45, %rbx #'-'
    je Negative
    cmp $43, %rbx #'+'
    je Next
Check:
    cmp $48, %rbx #'0'
    jl End
    cmp $57, %rbx #'9'
    jg End
Calculate:
    imul $10, %rax
    sub $48, %rbx
    add %rbx, %rax
Next:
    inc %rsi
    movb (%rsi), %bl
    jmp Check
Negative:
    mov $0, %rcx
    jmp Next
End:
    test %rcx, %rcx
    jnz Return
    neg %rax
Return:
    # mov %rax, %rdx
    # mov $1, %rax
    # mov $1, %rdi
    # mov $str, %rsi
    # syscall
    # mov $60, %rax
    # xor %rdi, %rdi
    # syscall
    ret
