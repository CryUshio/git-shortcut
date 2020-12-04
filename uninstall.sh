#!/bin/bash

echo "Your shell is: $SHELL"

home=`env | grep ^HOME= | cut -c 6-`
path=$home/scripts/git-shortcut

getEnvVarPath() {
  if [[ "$(uname)" == "Darwin" ]]; then
    # Mac OS X 操作系统
    if [[ "$SHELL" == *"bin/zsh" ]]; then
      echo "$home/.zshrc"
    else
      echo "$home/.bash_profile"
    fi
  elif [[ "$(expr substr $(uname -s) 1 5)" == "Linux" ]]; then
    # GNU/Linux操作系统
    if [[ "$SHELL" == *"bin/zsh" ]]; then
      echo "$home/.zshrc"
    else
      echo "$home/.bashrc"
    fi
  elif [[ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]]; then
    # Windows NT操作系统
    echo ''
  fi
}

envpath="$(getEnvVarPath)"
start=$(sed -n '/git-shortcut start/=' $envpath)
end=$(sed -n '/git-shortcut end/=' $envpath)

sed -i "" "${start},${end}d" $envpath
rm -rf "$path"

echo "Uninstall succeed."
