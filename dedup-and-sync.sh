#!/bin/bash

set -e

git checkout master
git pull origin master

TMP=$(mktemp)

sort -k2 hosts | uniq > ${TMP}
cat ${TMP} > hosts
rm -f ${TMP}

scp -rv orange:/opt/pihole ./opt/
scp -rv orange:/etc/pihole/adlists.list ./adlists.list
scp -rv orange:/etc/pihole/black.list ./black.list

git add .
git commit -am"refresh list $(date)"
git push origin master