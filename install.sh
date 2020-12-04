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

exsist() {
  echo $(grep -w "git-shortcut" "$(getEnvVarPath)")
}

envExsist() {
  grep 'g-completion' "$(getEnvVarPath)" >/dev/null 2>&1
}

writeEnv() {
  echo "# git-shortcut start
export PATH=\$PATH:$path
alias g=g
if [ -f "$path/g-completion.bash" ]; then
  . $path/g-completion.bash
fi
# git-shortcut end
" >> `getEnvVarPath`
}

# debug
# rm -rf ~/scripts

# release
sh ./build.sh

# create dir and copy files
rm -rf $path
mkdir -p $path
cp -r ./release/* $path
chmod +x $path/g
chmod +x $path/g-completion.bash

# set path
echo "Your env file: $(getEnvVarPath)"

if [ -z "$(exsist)" ]; then
  echo 'Setting env...'
  writeEnv
fi

# oh-my-zsh may throw errors in bash environment
source "$(getEnvVarPath)" >/dev/null 2>&1

if [ -f "$path/g" ] && envExsist; then
  cat <<eof

Install success! Please Restart your terminal.

Run \`g\` to see help.

eof
else
  echo 'Some errors occurred. Please check your command line environment.'
fi
