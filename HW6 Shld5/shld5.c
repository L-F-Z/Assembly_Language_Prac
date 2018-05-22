#include <stdio.h>
unsigned int shld5(unsigned int a, unsigned int b)
{
    unsigned int result;
    asm(
        "sall  $5, %1\n\t"
	    "shrl  $27, %0\n\t"
	    "orl   %1, %0"
        :"=r"(result)
        :"r"(a),"0"(b)
    );
    //result = (a << 5) |( b>>(32-5));
    return result;
}
int main()
{
    unsigned int a, b, result;
    a = 0x00000000;
    b = 0xFFFFFFFF;
    result = shld5(a, b);
    printf("     a = %x\n     b = %x\nresult = %x\n", a, b, result);
    a = 0xFFFFFFFF;
    b = 0x00000000;
    result = shld5(a, b);
    printf("     a = %x\n     b = %x\nresult = %x\n", a, b, result);
    return 0;
}