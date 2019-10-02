#! /bin/bash
. ./src/cmd.sh

input() {
  case $1 in
  ps)
    push
    ;;
  pl)
    pull
    ;;
  submit) ;;

  -)
    git checkout -
    ;;
  h | *)
    help
    ;;
  esac
}

help() {
  cat <<EOF
Usage: g <command>

<Commands>
  ps:  推送代码到当前远程分支
  pl:  拉取代码从指定远程分支
  submit[<comment>]:  一键推送
  -:  回到上一个分支
  merge:  拉取并 merge master

EOF
}

input $*
