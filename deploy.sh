#!/bin/zsh

# Quick Deploy Script for Flutter Web Portfolio
# This script builds Flutter web and copies files to root directory

set -e

echo "🚀 Building Flutter web..."
flutter clean
flutter pub get
flutter build web --release --base-href "/" --dart-define=ENVIRONMENT=production

echo "📋 Copying build files to root..."
cp -R build/web/* .

echo "✅ Build completed! Files ready for GitHub Pages."
echo "💡 Next steps:"
echo "   git add ."
echo "   git commit -m 'deploy: Flutter web build'"
echo "   git push origin main"