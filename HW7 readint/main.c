#include <stdio.h>
int readint(void);
int main(void)
{
  int num;
  num = readint();
  printf("Read num = %d\n", num);
  return 0;
}
