#! /bin/bash

getBranchs() {
  local result=$(git branch 2>&1 | sed "s/*//g")

  if [[ "$result" == *'fatal'* ]]; then
    echo ''
  else
    echo "$result"
  fi
}

echo $(getBranchs)
printf '%*s' "-$COLUMNS" "master"
