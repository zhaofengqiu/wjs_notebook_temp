#!/bin/sh
date2="\"$(date +%Y-%m-%d)-$(date +%H:%M:%S)"\"
git add . 

git commit -m $date2

git push -u origin master


echo $date2
