#include <stdlib.h>
int readint()
{
    int i = 1;
    char str[100];
    asm volatile(
    "mov $0, %%rax\n\t"
    "mov $1, %%rdi\n\t"
    "mov %0, %%rsi\n\t"
    "mov $100, %%rdx\n\t"
    "syscall"
    :
    :"r"(str)
    :"rax", "rdi", "rsi", "rdx"
    );
    while(str[i]>='0' && str[i]<='9')
        i++;
    str[i] = 0;
    return atoi(str);
}
