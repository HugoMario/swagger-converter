#!/usr/bin/python

import sys

# main
def main(tag):
    isSnapshot = False
    if "SNAPSHOT" in tag:
        tag = tag.replace("-SNAPSHOT", "")
        isSnapshot = True
    tagParts = tag.split(".")
    bumped = tagParts[0] + "." + tagParts[1] + "." + str(int(tagParts[2]) + 1)
    if isSnapshot:
        bumped += "-SNAPSHOT"
    print bumped
# here start main
main(sys.argv[1])