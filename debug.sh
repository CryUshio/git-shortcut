#! /bin/bash

util_isCmd() {
  if [[ "$1" == "-"* ]]; then
    echo "$1"
  fi
}

echo $(util_isCmd -a)
echo $(util_isCmd a)
