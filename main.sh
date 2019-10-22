#! /bin/bash
. ~/scripts/git-shortcut/src/cmd.sh

help() {
  cat <<EOF
Usage: g <command>

<Commands>
  ps:  推送代码到当前远程分支
  pl:  拉取代码从指定远程分支
  fh:  获取远程仓库变动
  cm:  <comment>?, 等同于 git commit
  sm:  <comment>?, 一键推送所有修改, git add . && git commit && git push
  -:  回到上一个分支
  merge:  拉取并 merge master

EOF
}

case $1 in
  ad)
    git add .
    ;;
  ps)
    push
    ;;
  pl)
    pull "$2"
    ;;
  fh)
    git fetch
    ;;
  cm)
    git commit "$2"
    ;;
  sm)
    submit "$2"
    ;;

  -)
    git checkout -
    ;;
  h | *)
    help
    ;;
  esac

