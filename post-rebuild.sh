#!/usr/bin/env bash
cd /etc/nixos
if git diff --quiet; then
  echo "No changes to commit."
else
  git add .
  git commit -m "Rebuild on $(date '+%Y-%m-%d %H:%M:%S')"
fi
