#!/bin/bash

repo='nightfly19.github.io'

if [ "${TRAVIS_BRANCH}" != "master" ];then
    echo "Not master, not publishing";
    exit 0;
fi

git clone https://github.com/${SECURE_GITHUB_USERNAME}/${repo}.git && \

rsync _site/ ./${repo}/ -tarv --delete --exclude=.git && \

cd $repo && \

git add -A && \

git commit -a -m "${TRAVIS_COMMIT}" && \

git push https://${SECURE_GITHUB_USERNAME}:${SECURE_GITHUB_PASSWORD}@github.com/${SECURE_GITHUB_USERNAME}/${repo}.git master
