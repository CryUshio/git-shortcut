#! /bin/bash

words=(1 2 3)

for (( i=0; i<${#words[@]}; i++ )) do
  echo "printf "${words[$i]}
done
