#!/bin/bash
len=$(cat data.txt | grep -c '[[:alnum:]]')
if [[ $len -gt 16 ]]; then
echo "Yes"
else 
echo "No"
fi;