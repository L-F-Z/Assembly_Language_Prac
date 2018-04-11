.section .data
stt: .string "aaaaaaaaaa"
sbuf:.string ""

.section .text
.globl _start
_start:
	movl    $-68, %eax
	call    int_write
	call    as_exit

    .global int_write
    .type int_write,@function
int_write:
    pushl    %edi
    pushl    %ebx
    pushl    %ecx
    pushl    %edx
    movl    $sbuf, %edi
    test    %eax,%eax
    pushf            #标志寄存器入栈
    jns    endNegate
    neg    %eax        #如果这个有符号整数是负数，则将其求负
endNegate:        
    movl    $10,%ebx    #因为除数不能为立即数，所以只好把10放到%ebx里

getLastDigit:
    cltd        #cltd，进行符号扩展(Convert Long To Double)
                #扩展完成后，%edx保存扩展数的高双字，%eax保存低双字
    idivl    %ebx        #经过除数为10的除法后，%eax保存商，%edx保存余数
    addb    $'0',%dl    #将%dl加上'0'，就将一个0~9范围的整数变成了它们相应的数字字符
    movb    %dl,(%edi)    #将转换后的字符放到缓冲区
    dec    %edi        #将缓冲区往前移，缓冲区指针是从后往前移的
    test    %eax,%eax
    jnz    getLastDigit

    popf            #标志寄存器出栈
    jns    endAddSign
    movb    $'-',(%edi)    #加上负号
    dec    %edi
endAddSign:
    inc    %edi
    movl    $4,%eax
    movl    $1,%ebx
    movl    %edi,%ecx
    movl    $sbuf,%edx
    subl    %edi,%edx
    inc    %edx #转换字符串的长度
    int    $0x80
    
    popl %edx        #恢复原来的寄存器
    popl %ecx
    popl %ebx
    popl %edi
    ret

    .globl  as_exit
    .type   as_exit, @function
as_exit:
	movl	$1, %eax
	movl	$0, %ebx
	int	$0x80
