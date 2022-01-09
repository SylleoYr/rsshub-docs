#!/bin/sh

###
 # @Author: Sylleo
 # @Version: 0.0.1
 # @Date: 2022-01-09 10:00:08
 # @LastEditTime: 2022-01-09 10:36:13
 # @LastEditors: Sylleo
 # @Description: 
 # @FilePath: /rsshub-docs/check_update.sh
 # @Environment: 
 # Copyright (C) 2022 Sylleo. All rights reserved.
### 

if [ -n "$(git status -s)" ]; then
    git status
    git config user.name SylleoYr
    git config user.email SylleoYr@users.noreply.github.com
    git add .
    git commit -m "Docs updated by GitHub Actions"
    git push -u origin master
else
    echo "There is no update."
fi
