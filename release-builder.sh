#!/bin/bash

# Check if jq and gh exists in the system.
command -v gh >/dev/null 2>&1 || { echo >&2 "Error: $0 script requires 'gh' to call GitHub APIs.  Aborting as not found."; exit 1; }

# Read and set variables.
GIT_TOKEN=$1
WORK_DIR=$2
GIT_USERNAME="ThilinaManamgoda"
GIT_EMAIL="maanafunedu@gmail.com"

# Login to github cli with token.
echo $GIT_TOKEN | gh auth login --with-token

## Read current version for the release tag.
#CURRENT_VERSION=$(jq -r '.release_tag_version' $WORK_DIR/release-info.json)
#
## Set current version for the release tag.
#TAG=v$CURRENT_VERSION
#TAG_NAME=helm-charts-v$CURRENT_VERSION
#
## Increment tag version to next tag version.
#MAJOR=$(echo $CURRENT_VERSION | cut -d. -f1)
#MINOR=$(echo $CURRENT_VERSION | cut -d. -f2)
#PATCH=$(echo $CURRENT_VERSION | cut -d. -f3)
#PATCH=$(expr $PATCH + 1)
#NEW_RELEASE_TAG_VERSION=$MAJOR.$MINOR.$PATCH
#
## Update the next version number in release-info.json.
#VERSION_UPDATE="$(jq --arg version "$NEW_RELEASE_TAG_VERSION" '.release_tag_version = $version' $WORK_DIR/release-info.json)" && echo "${VERSION_UPDATE}" > $WORK_DIR/release-info.json
#
## Push new release version to release-info.json.
#git -C $WORK_DIR config user.email "$GIT_EMAIL"
#git -C $WORK_DIR config user.name "$GIT_USERNAME"
#git -C $WORK_DIR add $WORK_DIR/release-info.json
#git -C $WORK_DIR commit -m "Update release tag version to - $NEW_RELEASE_TAG_VERSION"
#git -C $WORK_DIR push
#
## Release the tag including zip from base branch.
#gh release create --target base --title "$TAG_NAME" -n "" "$TAG";
