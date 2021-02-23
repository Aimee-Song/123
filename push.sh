#!/bin/bash

GITLAB_URL='ssh://git@gitlab.51idc.com:songyue/123.git'

# 删除gitlab服务器
git remote | grep gitlab | xargs -I @ git remote remove @

# 更新master分支
git fetch --all
git checkout master
git branch --set-upstream-to=origin/master master
git pull

# 删除所有本地分支（保留master），拉取创建所有远程分支
git branch  | grep -v HEAD | grep -v master | xargs -I @ git branch -D @
git branch -r --list "origin/*"  | grep -v HEAD | grep -v master | xargs -I @ git checkout -t @

# 添加gitlab服务器
git remote add gitlab $GITLAB_URL

git push -u gitlab --all
git push -u gitlab --tags

# 删除gitlab服务器
git remote remove gitlab