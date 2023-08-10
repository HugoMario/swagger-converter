#function bump {
#  local mode="$1"
#  local old="$2"
#  local parts=( ${old//./ } )
#  case "$1" in
#    major)
#      local bv=$((parts[0] + 1))
#      NEW_VERSION="${bv}.0.0"
#      ;;
#    minor)
#      local bv=$((parts[1] + 1))
#      NEW_VERSION="${parts[0]}.${bv}.0"
#      ;;
#    patch)
#      local bv=$((parts[2] + 1))
#      NEW_VERSION="${parts[0]}.${parts[1]}.${bv}"
#      ;;
#    esac
#}
pwd
CURRENT_VERSION="$(./CI/version.sh)"

echo "old version is: " ${CURRENT_VERSION}

#NEW_VERSION=${CURRENT_VERSION/-SNAPSHOT/}
#
#echo "new version is: " $NEW_VERSION " SNAPSHOT"
PARTS=( ${CURRENT_VERSION//./ })
BUMPED_VERSION=$((PARTS[2] + 1))
NEW_VERSION="${PARTS[0]}.${PARTS[1]}.${BUMPED_VERSION}-SNAPSHOT"

#bump $BUMP_MODE $CURRENT_VERSION

echo "pom.xml will be bumped from ${CURRENT_VERSION} to ${NEW_VERSION}"
mvn -q versions:set -DnewVersion="${NEW_VERSION}"
#  git add $POMPATH/pom.xml
#  REPO="https://$GITHUB_ACTOR:$TOKEN@github.com/$GITHUB_REPOSITORY.git"
#  git commit -m "Bump pom.xml from $CURRENT_VERSION to $NEW_VERSION"
#  git tag $NEW_VERSION
#  git push $REPO --follow-tags
#  git push $REPO --tags
