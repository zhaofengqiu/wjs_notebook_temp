#!/bin/sh
date2="\"$(date +%Y-%m-%d)' '$(date +%H:%M:%S)"\"
git add .

git commit -m $date2 $1&>/dev/null

git push -u origin master $1&>/dev/null
