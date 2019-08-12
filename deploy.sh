#!/bin/sh

# If a command fails then the deploy stops
set -e

printf "\033[0;32mDeploying updates to GitHub...\033[0m\n"

# Build the project.
git submodule add -b master git@github.com:faizsiddiqui/faizsiddiqui.github.io.git public
hugo -t hello-friend-ng

# Go To Public folder
cd public

# Commit changes.
msg="Rebuilding site $(date)"
if [ -n "$*" ]; then
	msg="$*"
fi
git commit -am "$msg"

# Push source and build repos.
git push origin master

# Remove public directory from develop
cd ../
rm -rf public
git rm -r public
