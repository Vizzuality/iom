#!/bin/sh
git checkout production
git pull origin production
git merge staging
git push origin production
git checkout master
cap deploy
