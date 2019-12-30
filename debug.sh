#! /bin/bash

util_isCommitId() {
  if [ -n "$1" ]; then
    echo "$1"
  fi
}

if [ -n "$(util_isCommitId "$1")" ]; then
 echo 'true'
fi
