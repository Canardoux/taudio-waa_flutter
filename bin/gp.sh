#!/bin/bash

#VERSION=$1
TXT=$1

if [ -z "$TXT" ]; then
        echo "Correct syntax is $0 <TEXT>"
        exit -1
fi

echo "gp.sh"
echo "------"

#if [ ! -z "$VERSION" ]; then
#        echo "Setting the τDio version"
#        gsed -i  "s/^TAU_VERSION:.*/TAU_VERSION: $VERSION/"                                     doc/_config.yml
#        gsed -i  "s/^\( *version: \).*/\1$VERSION/"                                             doc/_data/sidebars/mydoc_sidebar.yml
#fi

git add .
git commit -m "$TXT"
git config pull.rebase false
git pull
git push
