#!/bin/sh

cd ../../master
ls | grep -vE \.git.* | xargs rm -r
cd ..
cp -r development/_site/ master/
