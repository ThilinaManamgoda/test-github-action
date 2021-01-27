#!/bin/bash

# Check if jq and gh exists in the system.
command -v gh >/dev/null 2>&1 || { echo >&2 "Error: $0 script requires 'gh' to call GitHub APIs.  Aborting as not found."; exit 1; }

# Read and set variables.
GIT_TOKEN=$1
WORK_DIR=$2
GIT_USERNAME="ThilinaManamgoda"
GIT_EMAIL="maanafunedu@gmail.com"
CHART_YAML="${WORK_DIR}/Chart.yaml"

# Login to github cli with token.
echo $GIT_TOKEN | gh auth login --with-token

# Read current tag version from the Chart.yaml
CURRENT_TAG_VERSION_TMP=$(grep 'version:' "${CHART_YAML}")
CURRENT_TAG_VERSION=${CURRENT_TAG_VERSION_TMP//*version: /}

echo "Current tag version: ${CURRENT_TAG_VERSION}"

## Increment tag version to next tag version.
MAJOR=$(echo $CURRENT_TAG_VERSION | cut -d. -f1)
MINOR=$(echo $CURRENT_TAG_VERSION | cut -d. -f2)
PATCH=$(echo $CURRENT_TAG_VERSION | cut -d. -f3)
PATCH=$(expr $PATCH + 1)
NEW_RELEASE_TAG_VERSION=$MAJOR.$MINOR.$PATCH

echo "New release tag version: ${CURRENT_TAG_VERSION}"

# Set new release tag.
NEW_RELEASE_TAG="v${NEW_RELEASE_TAG_VERSION}"
TAG_NAME="test-github-action-v${NEW_RELEASE_TAG_VERSION}"

echo "New release tag: ${NEW_RELEASE_TAG}"
echo "New release tag name: ${TAG_NAME}"

# Push new release version to Chart.yaml
sed -i "s/version: ${CURRENT_TAG_VERSION}/version: ${NEW_RELEASE_TAG_VERSION}/" "${CHART_YAML}"

git -C $WORK_DIR config user.email "$GIT_EMAIL"
git -C $WORK_DIR config user.name "$GIT_USERNAME"
git -C $WORK_DIR add "${CHART_YAML}"
git -C $WORK_DIR commit -m "Update release tag version to - $NEW_RELEASE_TAG_VERSION"
git -C $WORK_DIR push

# Release the tag including zip from base branch.
gh release create --target base --title "${TAG_NAME}" -n "" "${NEW_RELEASE_TAG}";
