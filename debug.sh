#! /bin/bash

. "$(dirname $(greadlink -f $0))/src/utils.sh"

branchName=$(getBranchName)

if test -z "$branchName"; then
  echo 'fatal'
else
  echo $branchName
fi
