DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
echo $DIR

function bump {
  local mode="$1"
  local old="$2"
  local parts=( ${old//./ } )
  case "$1" in
    major)
      local bv=$((parts[0] + 1))
      NEW_VERSION="${bv}.0.0"
      ;;
    minor)
      local bv=$((parts[1] + 1))
      NEW_VERSION="${parts[0]}.${bv}.0"
      ;;
    patch)
      local bv=$((parts[2] + 1))
      NEW_VERSION="${parts[0]}.${parts[1]}.${bv}"
      ;;
    esac
}

OLD_VERSION="$($DIR/version.sh)"

echo "old version is: " $OLD_VERSION

OLD_VERSION=${OLD_VERSION/-SNAPSHOT/}
echo "old version AGAIN is: " $OLD_VERSION


NEW_VERSION=${OLD_VERSION/-SNAPSHOT/}

echo "new version is: " $NEW_VERSION

BUMP_MODE="patch"
if git log -1 | grep -q "#major"; then
  BUMP_MODE="major"
elif git log -1 | grep -q "#minor"; then
  BUMP_MODE="minor"
elif git log -1 | grep -q "#patch"; then
  BUMP_MODE="patch"
fi

echo $BUMP_MODE "version bump detected"
bump $BUMP_MODE $OLD_VERSION
echo "pom.xml at" $POMPATH "will be bumped from" $OLD_VERSION "to" $NEW_VERSION
mvn -q versions:set -DnewVersion="${NEW_VERSION}"
#  git add $POMPATH/pom.xml
#  REPO="https://$GITHUB_ACTOR:$TOKEN@github.com/$GITHUB_REPOSITORY.git"
#  git commit -m "Bump pom.xml from $OLD_VERSION to $NEW_VERSION"
#  git tag $NEW_VERSION
#  git push $REPO --follow-tags
#  git push $REPO --tags
