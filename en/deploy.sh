#!/bin/bash

# Deploy script for WSO2 API Manager Documentation
# This script ensures .nojekyll file is created before deployment

set -e

echo "🚀 Building WSO2 API Manager Documentation..."

# Navigate to the en directory
cd "$(dirname "$0")"

# Clean build
echo "📦 Building documentation..."
mkdocs build --clean

# Create .nojekyll file to disable Jekyll processing on GitHub Pages
echo "🔧 Creating .nojekyll file..."
touch site/.nojekyll

# Deploy to GitHub Pages
echo "🌐 Deploying to GitHub Pages..."
mkdocs gh-deploy --clean --ignore-version --message "Automated deployment with .nojekyll fix"

echo "✅ Deployment completed successfully!"
echo "📖 Your documentation is available at: https://dushaniw.github.io/docs-apim/"