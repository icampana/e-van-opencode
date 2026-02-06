#!/usr/bin/env bash

# Safe Commit Script
# Ensures code quality checks pass before committing.

set -e

MESSAGE="$1"

if [ -z "$MESSAGE" ]; then
    echo "Error: Commit message required."
    echo "Usage: ./scripts/safe_commit.sh "your commit message""
    exit 1
fi

echo "Starting safe commit process..."

# 1. Run Linting (if available)
if [ -f "package.json" ] && grep -q ""lint"" package.json; then
    echo "Running lint checks..."
    npm run lint
fi

# 2. Run Type Checking (if available)
if [ -f "tsconfig.json" ]; then
    echo "Running type checks..."
    npx tsc --noEmit
fi

# 3. Perform Commit
echo "Committing changes..."
git commit -m "$MESSAGE"

echo "Safe commit completed successfully."
