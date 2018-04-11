.section .data
testdata:
    .int 6, -5, 3, 1, -8, 7, 0, 2, 4, 9
Placeholder:
    .string "aaaaaaaaaa"
sbuf:
    .string ""

.section .text
.globl _start
_start:
	subl	$8, %esp
	movl	$10, 4(%esp)
    movl	$testdata, (%esp)
	call	Insert_sort
#output
    movl	$10, 4(%esp)
	movl	$testdata, (%esp)
	call	PrintArr
#exit
	call	as_exit

# --------PRINT_ARR--------
    .globl  PrintArr
    .type   PrintArr, @function
PrintArr:
	push	%ebx
	movl	8(%esp), %ebx
	movl	12(%esp), %ecx
    # subl    $3, %ebx
Print_Loop:
    movl    (%ebx), %eax 
    call    PrintInt
    addl    $4, %ebx 
    loop    Print_Loop
	pop	%ebx
    ret
# -------------------------

# --------PRINT_INT--------
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
# -------------------------

# ----------EXIT-----------
    .globl  as_exit
    .type   as_exit, @function
as_exit:
	movl	$1, %eax
	movl	$0, %ebx
	int	$0x80
# -------------------------

# -------INSERT_SORT-------
.text
	.globl	Insert_sort
	.type	Insert_sort, @function
Insert_sort:
	pushl	%ebp
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$4, %esp
	movl	28(%esp), %eax        # eax = n
	cmpl	$1, %eax              # Cmp(n ,1)
	jle	.Sort_End                 # if(n == 1) no Sort
	movl	24(%esp), %edi        # (edi = *a)
	subl	$1, %eax              # eax = n-1
	xorl	%ebp, %ebp            # ebp = 0
	movl	%eax, (%esp)          # flag (%esp) = n-1
	addl	$4, %edi              # edi = *a+1 = i
.Outer_Loop_Begin:
	movl	(%edi), %ebx          # (ebx = tmp = a[i])
	movl	-4(%edi), %ecx        # (ecx = a[j])
	movl	%ebp, %eax            # (eax = j)
	cmpl	%ecx, %ebx            # (ebx = tmp) (ecx = a[j])
	jge	.Jump_Inner_Loop          # if(a[j]<=tmp) continue
	movl	%edi, %edx            # (edx = edi = *a)
	jmp	.Inner_Loop_Begin
.Jump_Inner_Loop:
	movl	%ebp, %esi            # (esi = ebp = j)
	jmp	.Outer_Loop_Cmp

# ------Inner_Loop------
.Inner_Loop_Cmp:
	subl	$4, %edx              # (edx = *a)
	movl	-4(%edx), %ecx        # (ecx = a[j])
	cmpl	%ebx, %ecx            # (ebx = tmp) (ecx = a[j])
	jle	.Outer_Loop_Cmp           # if(a[j]<=tmp) break
.Inner_Loop_Begin:
	subl	$1, %eax              # (eax = j) j--
	movl	%ecx, (%edx)          # (a[j+1] = ecx = a[j])
	cmpl	$-1, %eax             # (eax = j)
	movl	%eax, %esi            # (esi = eax = j)
	jne	.Inner_Loop_Cmp           # break until j == -1
# ------Inner_Loop------

.Outer_Loop_Cmp:
	addl	$1, %ebp              # (ebp = Outer_Count) count++
	addl	$4, %edi              # (edi = Pointer) Pointer++
	cmpl	%ebp, (%esp)          # Cmp(count, n)
	movl	24(%esp), %eax        # (eax = j)
	movl	%ebx, 4(%eax,%esi,4)  # ?
	jne	.Outer_Loop_Begin
.Sort_End:
	addl	$4, %esp
	popl	%ebx
	popl	%esi
	popl	%edi
	popl	%ebp
	ret
# -------------------------
