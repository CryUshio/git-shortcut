## Description
自用型 `git` 快捷命令（仅支持 mac os、linux）

## Install
```
git clone https://github.com/chym123/git-shortcut.git
cd git-shortcut
bash install.sh
```

## Usage
```
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
  tg:  [empty], git tag, 显示当前 tag 列表
       <tag name>, git tag -a, 添加一个 tag
       <tag name> <comment?>, git tag -a <tag name> <-m<comment>?>, 添加一个带注释的 tag
       <tag name> -p, git push origin <tag name>, 推送一个 tag
       <tag name> <comment?> -s, create and submit a tag, 创建并推送一个 tag
       <tag name> -d, git tag -d <tag name> && git push origin :<tag name>, 删除一个 tag

  g <h|help>: For help
  g <cmd>: git <cmd>
```
