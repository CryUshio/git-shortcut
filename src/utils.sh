#! /bin/bash

exsist() {
  command -v $1 >/dev/null 2>&1
}

getBranchName() {
  result=$(git symbolic-ref --short -q HEAD 2>&1)
  fatal=$(echo "$result" | grep '^fatal')

  if test -n "$fatal"; then
    echo 
  else
    echo $result
  fi
}
