#!/bin/sh

set -e

TARGET_REPO=$1
GITHUB_TOKEN=$2
REPOSITORY_OWNER=$3
REPOSITORY=$4

SOURCE_REPO="https://${REPOSITORY_OWNER}:${GITHUB_TOKEN}@github.com/${REPOSITORY}.git"

# Clone mirror from source repository
git clone --mirror "$SOURCE_REPO" /root/source && cd /root/source

git remote add target "$TARGET_REPO"

if [[ -n "$TARGET_SSH_PRIVATE_KEY" ]]; then
  # Push using destination ssh key if provided  
  config="/usr/bin/ssh -i ~/.ssh/dst_rsa -o StrictHostKeyChecking=no"

  # Append SSH username - requirement of AWS CodeCommit
  if [[ -n "$TARGET_SSH_USERNAME" ]]; then
    config="$config -l $TARGET_SSH_USERNAME"
  fi

  # Set SSH config
  git config --local core.sshCommand "$config"
fi

# Push mirror to target repository
git push --mirror target