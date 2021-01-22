BEGIN {
#include<stdio.h>
}
{
if($6=="cwnd_") # don‟t leave space after writing cwnd_
printf("%f\t%f\t\n",$1,$7); # you must put \n in printf
}
END {
}
