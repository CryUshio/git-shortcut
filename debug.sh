#! /bin/bash

exsist() {
  command -v $1 >/dev/null 2>&1
}

if ! exsist greadlink; then
  if test -n $(echo readlink -f | grep 'illegal'); then
    cat <<eof
Your system not support \`readlink -f\`, please install coreutils:
    brew install coreutils

eof
    exit
  else
    cur_path="$(dirname $(readlink -f $0))"
  fi
else
  cur_path="$(dirname $(greadlink -f $0))"
fi

echo "$cur_path"
