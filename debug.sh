#! /bin/bash

branchName=$([ "$2" == "-D" ] && echo "$1" || echo "$1 $2")
cmd="${!#}"
# if [ "$cmd" == "-D" ]; then
#   git branch -D $branchName
# else
#   git branch -d $branchName
# fi

echo $branchName
echo cmd = $cmd
