#include <stdio.h>
extern int showStack(int);
int main()
{
int x,i;
int value;
printf("Give the number of items you want:	");
scanf("%d", &x);

for(i = 0; i < x ; ++i)
{
	value = showStack(i);
	printf("%d\n", value);
}
return 0 ;

}

