BEGIN{
#include<stdio.h>
pktDropsRtr1=0;
}
{
     if($1=="d")   #d stands for the packets drops. 
     {
         pktDropsRtr1++;
     } 
          
}
END{
printf("Number of Packets Dropped at Router : %d \n", pktDropsRtr1);

}
