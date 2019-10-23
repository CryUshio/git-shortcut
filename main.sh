#! /bin/bash
. "$GIT_SHORTCUT_HOME/src/cmd.sh"

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
  mg:  git merge <branchName?>, 拉取并 merge 目标分支, 默认 merge master

EOF
}

case_key=$1
shift
case $case_key in
ad)
  git add .
  ;;
br)
  git branch
  ;;
ck)
  git checkout
  ;;
+)
  git checkout -b "$1"
  ;;
-)
  git checkout -
  ;;
ps)
  push
  ;;
pl)
  pull "$1"
  ;;
fh)
  git fetch
  ;;
cm)
  cm_1="$1"
  shift
  commit "$cm_1" $*
  ;;
sm)
  sm_1="$1"
  shift
  submit "$sm_1" $*
  ;;
mg)
  merge $1
  ;;

h | *)
  help
  ;;
esac
