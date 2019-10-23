#! /bin/bash
. ~/scripts/git-shortcut/src/cmd.sh

help() {
  cat <<EOF
Usage: g <command> <...?>

<Commands>
  ad:  git add .
  b :  git branch
  ck:  git checkout <branchName>
  + :  git checkout -b <branchName>
  - :  git checkout -, 回到上一个分支
  ps:  git push origin [current branch], 推送代码到当前远程分支
  pl:  git pull origin <branchName>?, 从远程分支拉取代码
  fh:  git fetch, 获取远程仓库变动
  cm:  <comment?|cmd?>, git commit <-m comment?|cmd?>
  sm:  <comment>?, g ad && g cm && g ps, 一键推送所有修改
  merge:  拉取并 merge master

EOF
}

case $1 in
  ad)
    git add .
    ;;
  b)
    git branch
    ;;
  ck)
    git checkout
    ;;
  +)
    git checkout -b "$2"
    ;;
  -)
    git checkout -
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
    commit "$2"
    ;;
  sm)
    submit "$2"
    ;;

  h | *)
    help
    ;;
  esac

