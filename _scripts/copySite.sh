#!/bin/sh

cd ../../master
git pull
ls | grep -vE \.git.* | xargs rm -r
cd ..
cp -r development/_site/ master/
