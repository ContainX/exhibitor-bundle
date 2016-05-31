#!/bin/bash

# Exhibitor
mkdir -p exhibitor-bundle/exhibitor
git clone https://github.com/dcos/exhibitor.git
cd exhibitor
./gradlew install
./gradlew -b exhibitor-standalone/src/main/resources/buildscripts/standalone/gradle/build.gradle shadowJar
mv exhibitor-standalone/src/main/resources/buildscripts/standalone/gradle/build/libs/exhibitor-*-all.jar ../exhibitor-bundle/exhibitor/exhibitor.jar
cd ..
curl -Lo exhibitor-bundle/zookeeper.tgz $ZK_RELEASE
cd exhibitor-bundle

# ZooKeepr
tar -xvzf zookeeper.tgz && rm zookeeper.tgz
mv zookeeper-$ZK_VERSION zookeeper
rm -rf zookeeper/{src,docs,contrib}

# Supporting files
mv ../support/* ./

# Packaging
cd ..
tar -cvzf exhibitor-bundle.tgz exhibitor-bundle/
