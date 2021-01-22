BEGIN{
#include<stdio.h>
count=0;
}
{
     if($1=="d")#d stands for the packets drops. 
     {
         count++;
     } 
}
END{
printf("Number of Packets Dropped is: %d \n", count);
}
