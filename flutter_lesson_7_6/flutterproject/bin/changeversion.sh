#!/bin/bash
versionName=$1
sed -i '' '13c\
const targetVersion = "'${versionName}'";
' upload.dart