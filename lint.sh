#!/usr/bin/env bash
# Run all linters for Template DotNet Tool

set -e  # Exit on error

echo "📝 Checking markdown..."
npx markdownlint-cli2 "**/*.md"

echo "🔤 Checking spelling..."
npx cspell "**/*.{cs,md,json,yaml,yml}" --no-progress --no-color

echo "📋 Checking YAML..."
yamllint -c .yamllint.yaml .

echo "🎨 Checking code formatting..."
dotnet format --verify-no-changes

echo "✨ All linting passed!"
