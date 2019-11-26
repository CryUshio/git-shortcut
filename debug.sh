#! /bin/bash

branchName=$([[ "$2" == '-'* ]] && echo "$1" || echo "$1 $2")
cmd="${!#}"

if [ "$cmd" == "-r" ]; then
  echo remote, $branchName
elif [ "$cmd" == "-D" ]; then
  echo -D, $branchName
else
  echo -d, $branchName
fi

