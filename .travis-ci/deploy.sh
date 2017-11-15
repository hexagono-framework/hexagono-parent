#!/usr/bin/env bash

if [ ! -z "$TRAVIS_TAG" ]
then
    echo "on a tag -> set pom.xml <version> to $TRAVIS_TAG"
    mvn --settings .travis-ci/settings.xml org.codehaus.mojo:versions-maven-plugin:2.3:set -DnewVersion=$TRAVIS_TAG -Prelease
    mvn clean deploy --settings .travis-ci/settings.xml -DskipTests=true --batch-mode --update-snapshots -Prelease
else
    echo "not on a tag -> keep snapshot version in pom.xml"
    mvn clean deploy --settings .travis-ci/settings.xml -P release -DskipTests=true -B -U
fi