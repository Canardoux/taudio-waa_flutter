#!/bin/bash


echo "dart doc"
rm -rf doc/api 2>/dev/null
export PATH="$PATH:/opt/flutter/bin"
export FLUTTER_ROOT=/opt/flutter
flutter clean
flutter pub get
flutter pub global activate dartdoc
flutter pub global run dartdoc .