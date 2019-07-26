#! /bin/bash

push() {
  branchName=`git symbolic-ref --short -q HEAD 2>&1`
  echo "branch = $branchName."
  if test -z "$branchName" ; then
  echo 'yes'
  else
  echo 'no'
  fi
  # git push origin branchName
}