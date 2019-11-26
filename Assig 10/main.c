//Assignment 10 - Andrei Mircea Suciu
//5.Read the signed numbers a, b and c on type byte; calculate and display a+b-c. 

#include <stdio.h>

int sumN(int a, int b, int c);

int main()
{
    // declare variables
    int a = 0; 
    int b = 0;
    int c = 0;
    int sum = 0;

    // read the two integers from the keyboard
    printf("a=");
    scanf("%d", &a);

    printf("b=");
    scanf("%d", &b);
    
    printf("c=");
    scanf("%d", &c);

    // call the function written in assembly language
    sum = sumN(a, b, c);
    
    // display the result
    printf("The sum is %d", sum);
    
    return 0;
}