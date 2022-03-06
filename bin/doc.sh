#!/bin/bash


echo "dart doc"
rm -rf doc/api 2>/dev/null
export PATH="$PATH:/opt/flutter/bin"
export FLUTTER_ROOT=/opt/flutter
flutter clean
flutter pub get
flutter pub global activate dartdoc
flutter pub global run dartdoc .

cd doc/api
echo "patch css for Jekyll compatibility"
gsed -i  "0,/^  overflow: hidden;$/s//overflow: auto;/"  static-assets/styles.css
gsed -i  "s/^  background-color: inherit;$/  background-color: #2196F3;/" static-assets/styles.css

echo "Add Front matter on top of dartdoc pages"
for f in $(find . -name '*.html' )
do
        gsed -i  "1i ---" $f
        gsed -i  "1i ---" $f
        gsed -i  "/^<script src=\"https:\/\/ajax\.googleapis\.com\/ajax\/libs\/jquery\/3\.2\.1\/jquery\.min\.js\"><\/script>$/d" $f
done
cd ../..


