#!/bin/bash

git add .
VERSION=$1

if [ -z "$VERSION" ]; then
        echo "Correct syntax is $0 <VERSION>"
        exit -1
fi


dart analyze lib
if [ $? -ne 0 ]; then
    echo "Error"
    exit -1
fi
dart format lib
if [ $? -ne 0 ]; then
    echo "Error"
    exit -1
fi

dart analyze example/lib
if [ $? -ne 0 ]; then
    echo "Error"
    exit -1
fi
dart format example/lib
if [ $? -ne 0 ]; then
    echo "Error"
    exit -1
fi



flutter pub publish
