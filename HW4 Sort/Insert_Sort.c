#include <stdio.h>
void insert_sort(int a[ ], int n)
{
    int i;
    int j, tmp;
    for(i = 1; i<n; i++)
    {
       tmp = a[i];
       j = i - 1;
       while(j >=0 && a[j] >tmp)
       {
          a[j+1] = a[j];
          j--;
       }
       a[j+1]=tmp;
    }
}
void main()
{
    int i;
    int a[10] = {6, -5, 3, 1, -8, 7, 0, 2, 4, 9};
    insert_sort(a, 10);
    for(i = 0; i < 9; i++)
        printf("%d ", a[i]);
}
