#!/bin/sh

jekyll b
cd _scripts/
./copySite.sh
cd ../../master
git add .
git commit -m "Automated commit from development branch."
git push

