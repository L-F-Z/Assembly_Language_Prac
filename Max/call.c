#include <stdio.h>

int max(int x, int y)
{
  int z;

  if(x > y)
    z = x;
  else z = y;
  return z;
}

int main(void)
{
   int a = 3,b = 13,c;

   c = max(a,b);
   printf("max = %d\n", c);
   return 0;
}