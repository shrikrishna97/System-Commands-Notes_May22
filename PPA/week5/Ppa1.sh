#!/bin/bash

i=1;
for agr in $@;
# $@ means all the arguments
do
    if [ $(( i%2 )) -ne 0 ]; # -ne means not equals and when ever want maths calculation result use $ before ((  ))
    then
    echo -n "$agr "; # -n means print no new line 
    fi;
    ((i++))
done
