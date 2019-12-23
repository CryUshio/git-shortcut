help() {
  cat <<EOF
Usage: g <command> <...?>

<Commands>
  ad:  git add .
  br:  git branch <...>
  cl:  <url>, git clone <...>
  ck:  <branchName>, git checkout <branchName>
  rn:  <new branchName>, rename recent branch
  rm:  <branchName>, git branch -d <branchName>
       <branchName> -D, git branch -D <branchName>
       <branchName> -r, git push origin :<branchName>
  ma:  git checkout master
  + :  <branchName>, git checkout -b <branchName>, press \`tab\` to add today's date (eg. \`20191122\`)
  - :  git checkout -, 回到上一个分支
  ps:  git push origin [current branch], 推送代码到当前远程分支
  pl:  git pull origin <branchName>?, 从远程分支拉取代码
  fc:  git fetch, 获取远程仓库变动
  cm:  <comment?|cmd?>, git commit <-m comment?|cmd?>
  sm:  <comment?>, git add . && git commit -m <comment?|'feat: update.'> && git push, 一键推送所有修改
  mg:  <branchName?>, git merge <branchName?>, 拉取并 merge 目标分支, 默认 merge master
  st:  <cmd?>, git stash <cmd?>

  g <h|help>: For help
  g <cmd>: git <cmd>
EOF
}

case_key=$1
shift
case $case_key in
ad)
  git add .
  ;;
br)
  git branch $*
  ;;
cl)
  git clone $*
  ;;
ck)
  git checkout $1
  ;;
rn)
  cmd_rename $1
  ;;
rm)
  cmd_remove $*
  ;;
ma)
  git checkout master
  ;;
+)
  cmd_newBranch $*
  ;;
-)
  git checkout -
  ;;
ps)
  cmd_push $1
  ;;
pl)
  cmd_pull "$1"
  ;;
fc)
  git fetch
  ;;
cm)
  cm_1="$1"
  shift
  cmd_commit "$cm_1" $*
  ;;
sm)
  sm_1="$1"
  shift
  cmd_submit "$sm_1" $*
  ;;
mg)
  cmd_merge $1 $2
  ;;
st)
  git stash $*
  ;;

h | help | "")
  help
  ;;
*)
  git $case_key $*
  ;;
esac
