#!/bin/bash
a=`cat result`
b=`grep "$a " map | cut -d "/" -f3`;
c=`grep "INVESTMENT " -r   | cut -d "/" -f2`;
sum=0;
for i in $b;
do 
    d=`echo "$c " | grep "$i" | cut -d "$" -f2` 
    # grep "$i" $c
    # if [ $i in data ];then  
    # echo $d 
    for j in $d;
    do
        $((sum+=j));
    # echo $i
    # fi;
    done
    done
    echo $sum
#  ls -l 

# grep "INVESTMENT" -r   | cut -d "/" -f2   