#!/usr/bin/env bash

home=`env | grep ^HOME= | cut -c 6-`
path=$home/scripts/git-shortcut

getEnvVarPath() {
  if [ "$(uname)" == "Darwin" ]; then
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
  command -v $1 >/dev/null 2>&1
}

envExsist() {
  grep 'g-completion' "$(getEnvVarPath)" >/dev/null 2>&1
}

writeEnv() {
  echo "export PATH=\$PATH:$path
if [ -f "$path/g-completion.bash" ]; then
  . $path/g-completion.bash
fi" >> `getEnvVarPath`
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
if ! exsist g; then
  if ! envExsist; then
    writeEnv
  fi

  source "$(getEnvVarPath)"
fi

if [ -f "$path/g" ] && envExsist; then
  cat <<eof
Install success! Restart your Terminal to take effect.

Run \`g h\` to read helps.

eof
else
  echo 'Some errors occurred. Please try agnin.'
fi

# apply configuration

# debug
# ls -l $path
