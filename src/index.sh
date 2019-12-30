help() {
  cat <<EOF
Usage: g <command> <...?>

<Commands>
  ad:  git add .
  br:  git branch <...>
  cl:  <url>, git clone <url>
  ck:  <branchName>, git checkout <branchName>
  rn:  <newBranchName>, rename recent branch, 重命名当前分支
  rm:  <branchName>, git branch -d <branchName>, 删除本地分支
       <branchName> -D, git branch -D <branchName>, 强制删除本地分支
       <branchName> -r, git push origin :<branchName>, 删除远程分支
  ma:  git checkout master
  + :  <branchName>, git checkout -b <branchName>, press \`tab\` to add today's date (eg. \`20191122\`), 从当前分支创建新分支
  - :  git checkout -, 回到上一个分支
  ps:  git push origin [currentBranch], 推送代码到当前远程分支
  pl:  git pull origin <branchName>?, 从远程分支拉取代码
  fc:  git fetch, 获取远程仓库变动
  cm:  <comment?|cmd?>, git commit <-m comment?|cmd?>, 提交缓冲区的代码
  sm:  <comment?>, git add . && git commit -m <comment?|'feat: update.'> && git push, 一键推送所有修改
  mg:  <branchName?>, git merge <branchName?>, 拉取并 merge 目标分支, 默认 merge master
  st:  <cmd?>, git stash <cmd?>
  tg:  [empty], git tag -n, 显示当前 tag 列表和注释
       <tagName>, git tag -a, 添加一个 tag
       <tagName> <comment>, git tag -a <tagName> <-m<comment>?>, 添加一个带注释的 tag
       <tagName> <comment?> <commitId>, git tag -a <tagName> <-m<comment>?> <commit id>, 在指定提交对象上添加一个 tag
       <tagName> -p, git push origin <tagName>, 推送一个 tag
       <tagName> <comment?> <commitId?> -s, create and submit a tag, 创建并推送一个 tag
       <tagName> -d, git tag -d <tagName>, 删除一个 tag
       <tagName> -dr, git push origin :<tagName>, 删除一个远程 tag

  g -v: show current version
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
tg)
  cmd_tag "$1" "$2" "$3" "$4"
  ;;

h | help | "")
  help
  ;;
-v)
  echo $version
  ;;
*)
  git $case_key $*
  ;;
esac
