#! /bin/bash

exsist() {
  command -v $1 >/dev/null 2>&1;
}

getBranchName() {
  result=`git symbolic-ref --short -q HEAD 2>&1`
  echo "result=$result"
  echo `"$result" | grep '^fatal'`
}