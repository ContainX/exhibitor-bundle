#!/bin/bash

export ZK_VERSION=3.4.6
export ZK_RELEASE=http://www.apache.org/dist/zookeeper/zookeeper-$ZK_VERSION/zookeeper-$ZK_VERSION.tar.gz

mkdir -p exhibitor-bundle/exhibitor
git clone https://github.com/dcos/exhibitor.git
cd exhibitor
./gradlew install
./gradlew -b exhibitor-standalone/src/main/resources/buildscripts/standalone/gradle/build.gradle shadowJar
mv exhibitor-standalone/src/main/resources/buildscripts/standalone/gradle/build/libs/exhibitor-*-all.jar ../exhibitor-bundle/exhibitor/exhibitor.jar
cd ..
curl -Lo exhibitor-bundle/zookeeper.tgz $ZK_RELEASE
cd exhibitor-bundle
tar -xvzf zookeeper.tgz && rm zookeeper.tgz
rm -rf zookeeper/{src,docs,contrib}
cd ..
tar -cvzf exhibitor-bundle.tgz exhibitor-bundle/
