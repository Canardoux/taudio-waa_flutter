#!/bin/bash

git add .
TXT=$1

if [ -z "$TXT" ]; then
        echo "Correct syntax is $0 <TEXT>"
        exit -1
fi




git add .
git commit -m "$TXT"
git config pull.rebase false
git pull
git push

