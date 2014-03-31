#!/bin/bash

repo='nightfly19.github.io'


if [ "${TRAVIS_BRANCH}" != "master" ];then
    echo "Not master, not publishing";
    exit 0;
fi

git config --global user.email "nobody@nowhere.net"
git config --global user.name "Jekyll Robot"

git clone https://github.com/${SECURE_GITHUB_USERNAME}/${repo}.git && \

rsync _site/ ./${repo}/ -tar --delete --exclude=.git && \

cd $repo && \

git add -A && \

git commit -a -m "${TRAVIS_COMMIT}"

if [ "$?" -eq "1" ];then
    echo "Nothing changed, not publishing";
    exit 0;
fi

git push https://${SECURE_GITHUB_USERNAME}:${SECURE_GITHUB_PASSWORD}@github.com/${SECURE_GITHUB_USERNAME}/${repo}.git master &> /dev/null
