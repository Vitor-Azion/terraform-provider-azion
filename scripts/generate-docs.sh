#!/usr/bin/env bash
#
# Generate the documentation using tfplugindocs and remove changes to files that
# shouldn't change

exclude_files=()

## Check if manual changes were made to any excluded files and exit
# otherwise these will be lost with `tfplugindocs`
if [ "$(git status --porcelain "${exclude_files[@]}")" ]; then
  echo "Uncommitted changes were detected to the following files. These aren't autogenerated, please commit or stash these changes and try again"
  echo $(git status --porcelain "${exclude_files[@]}")
  exit 1
fi

$(go env GOPATH)/bin/tfplugindocs generate\
  -rendered-provider-name "Azion"

# Remove the changes to files we don't autogenerate
git checkout HEAD -- "${exclude_files[@]}"