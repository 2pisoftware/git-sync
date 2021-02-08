#!/bin/sh

set -e

if [[ -n "$TARGET_SSH_PRIVATE_KEY" ]]; then
  mkdir -p /root/.ssh
  echo "$TARGET_SSH_PRIVATE_KEY" | sed 's/\\n/\n/g' >/root/.ssh/dst_rsa
  chmod 600 /root/.ssh/dst_rsa
fi

mkdir -p ~/.ssh
cp /root/.ssh/* ~/.ssh/ 2>/dev/null || true

sh -c "/git-mirror.sh $*"