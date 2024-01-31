#!/bin/sh

echo "Installing git hooks\n"

echo "Copying contents of .git_hooks into .git/hooks\n"
cp .git_hooks/* .git/hooks

echo "Install complete!"
