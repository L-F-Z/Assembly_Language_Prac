.section .data
stt: .string "aaaaaaaaaa"
sbuf:.string ""

.section .text
.globl _start
_start:
    movl    $-124, %eax
    call    PrintInt
    movl    $56, %eax
    call    PrintInt
#Exit
    movl    $1, %eax
    movl    $0, %ebx
    int     $0x80

#-----------------------

    .global PrintInt
    .type PrintInt, @function
PrintInt:
    pushl   %edi
    pushl   %ebx
    pushl   %ecx
    pushl   %edx
    movl    $sbuf, %edi
    movb    $' ', (%edi)
    dec     %edi
    test    %eax, %eax
    pushf
    jns     PrintInt_Positive
    neg     %eax
PrintInt_Positive:        
    movl    $10, %ebx
PrintInt_Digit:
    cltd
    idivl   %ebx
    addb    $'0', %dl
    movb    %dl, (%edi)
    dec     %edi
    test    %eax, %eax
    jnz     PrintInt_Digit
    popf
    jns     PrintInt_Signed
    movb    $'-',(%edi)
    dec     %edi
PrintInt_Signed:
    inc     %edi
    movl    $4, %eax
    movl    $1, %ebx
    movl    %edi, %ecx
    movl    $sbuf, %edx
    subl    %edi, %edx
    inc     %edx
    int     $0x80
    popl    %edx
    popl    %ecx
    popl    %ebx
    popl    %edi
    ret
