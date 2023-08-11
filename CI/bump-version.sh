#!/bin/bash

CURRENT_VERSION="$(./CI/version.sh)"

echo "old version is: " ${CURRENT_VERSION}

delimiter='.'
s=$CURRENT_VERSION$delimiter
PARTS=();
while [[ $s ]]; do
    PARTS+=("${s%%"$delimiter"*}");
    s=${s#*"$delimiter"};
done;

BUMPED_VERSION=$((PARTS[2] + 1))
NEW_VERSION="${PARTS[0]}.${PARTS[1]}.${BUMPED_VERSION}-SNAPSHOT"

echo "pom.xml will be bumped from ${CURRENT_VERSION} to ${NEW_VERSION}"
mvn -q versions:set -DnewVersion="${NEW_VERSION}"
