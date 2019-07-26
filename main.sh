#! /bin/bash
. ./src/utils.sh

input() {
  case $1 in
  say)
    sayHello $2
    ;;
  ps)
    push
    ;;
  submit) ;;

  -)
    git checkout -
    ;;
  h|*)
    help
    ;;
  esac
}

help() {
  cat << EOF
Usage: g <command>

<Commands>
  ps:  推送代码到当前远程分支
  submit[<comment>]:  一键推送
  -:  回到上一个分支
  merge:  拉取并 merge master

EOF
}

input $*
