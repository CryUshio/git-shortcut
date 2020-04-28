#!/bin/bash

echo $SHELL

home=`env | grep ^HOME= | cut -c 6-`
path=$home/scripts/git-shortcut

getEnvVarPath() {
  if [ "$(uname)" == "Darwin" ]; then
    # Mac OS X 操作系统
    echo "$home/.bash_profile"
  elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    # GNU/Linux操作系统
    echo "$home/.bashrc"
  else
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

writeEnv() {
  echo "export PATH=\$PATH:$path
alias g=g
if [ -f "$path/g-completion.bash" ]; then
  . $path/g-completion.bash
fi" >> `getEnvVarPath`

echo "export PATH=\$PATH:$path
alias g=g
if [ -f "$path/g-completion.bash" ]; then
  . $path/g-completion.bash
fi" >> "$home/.zshrc"
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
if [ -z "$(exsist)" ]; then
  writeEnv
fi
source "$(getEnvVarPath)"
source "$home/.zshrc"

if [ -f "$path/g" ] && envExsist; then
  cat <<eof
Install success! Please Restart your Terminal.

Run \`g\` to read helps.

eof
else
  echo 'Some errors occurred. Please try agnin.'
fi

# apply configuration

# debug
# ls -l $path
