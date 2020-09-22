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
Usage: g <command> [...]

<Commands>
  ad                git add .
  br <branch>       git branch <branch>
  qr <string>       query branches, 模糊查询分支列表
  cl <url>          git clone <url>
  ck <branch>       git checkout <branch>
  rn <newName>      rename recent branch, 重命名当前分支
  rm <branch>       git branch -d <branch>, 删除本地分支
     <branch> -D    git branch -D <branch>, 强制删除本地分支
     <branch> -r    git push origin :<branch>, 删除远程分支
  ma                git checkout master
  + <branch>        git checkout -b <branch>, press \`tab\` to add today's date (eg. \`20191122\`), 从当前分支创建新分支
  -                 回到上一个分支
  ps                git push origin {currentBranch}, 推送代码到当前远程分支
  pl [branch]       git pull origin <branch|{currentBranch}>, 从远程分支拉取代码
  fc                git fetch, 获取远程仓库变动
  cm [comment|cmd]  git commit [-m comment|cmd], 提交缓冲区的代码
  sm [comment]      git add . && git commit -m <comment|'feat: update.'> && git push, 一键推送所有修改
  mg [branch]       git merge <branch|'master'>, 拉取并 merge 目标分支, 默认 merge master
  st [cmd]          git stash [cmd]
  tg                git tag -n, 显示当前 tag 列表和注释
     <tagName>            git tag -a, 添加一个 tag
     <tagName> [comment]  git tag -a <tagName> [-m <comment>], 添加一个带注释的 tag
     <tagName> [comment] <commitId>, git tag -a <tagName> [-m <comment>] <commit id>, 在指定提交对象上添加一个 tag
     <tagName> -p, git push origin <tagName>, 推送一个 tag
     <tagName> [comment] [commitId] -s, create and submit a tag, 创建并推送一个 tag
     <tagName> -d         git tag -d <tagName>, 删除一个 tag
     <tagName> -dr        git push origin :<tagName>, 删除一个远程 tag

  g -v              Show current version
  g <-h|help>        For help
  g <cmd>           git <cmd>
```
