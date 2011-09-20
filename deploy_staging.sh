#!/bin/sh
git pull origin master
git checkout staging
git merge master
git pull origin staging
git push origin staging
git checkout master
cap staging deploy
