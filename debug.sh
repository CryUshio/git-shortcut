#! /bin/bash

is_git_repo() {
  [ -d .git ] || git rev-parse --git-dir > /dev/null 2>&1
}

if [ ! is_git_repo ];then
echo 1
fi