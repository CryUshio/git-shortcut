#!/bin/bash

words=(1 2 3)

for (( i=0; i<${#words[@]}; i++ )) do
  echo "$(printf '%*s' "-$COLUMNS" "${words[$i+1]}")"
done
