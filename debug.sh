#!/usr/bin bash

home=`env | grep ^HOME= | cut -c 6-`
path=$home/scripts/git-shortcut

getEnvVarPath() {
  if [ "$SHELL" == "/bin/zsh" ]; then
    echo "$home/.zshrc"
  elif [ "$(uname)" == "Darwin" ]; then
    # Mac OS X 操作系统
    echo "$home/.bash_profile"
  elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    # GNU/Linux操作系统
    echo "$home/.bashrc"
  elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
    # Windows NT操作系统
    echo ''
  fi
}

exsist() {
  echo $(grep -w "$path" "$(getEnvVarPath)")
}

envExsist() {
  grep 'g-completion' "$(getEnvVarPath)" >/dev/null 2>&1
}

echo $(getEnvVarPath)

if [ -n "$(exsist)" ]; then
  if ! envExsist; then
    echo 'write'
  fi

  alias g='g'
  echo 'source'
fi
