#!/bin/zsh

# Deploy Script for Flutter Web Portfolio
# This script triggers GitHub Actions deployment (recommended approach)

set -e

echo "🚀 Flutter Web Portfolio Deployment"
echo "═══════════════════════════════════════"
echo ""
echo "⚠️  IMPORTANT: Don't commit build artifacts to git!"
echo "✅ Use GitHub Actions for automatic deployment instead."
echo ""
echo "🔧 How it works:"
echo "   1. Push your source code changes to main branch"
echo "   2. GitHub Actions automatically builds Flutter web"
echo "   3. GitHub Pages serves the built site"
echo ""
echo "📋 To deploy your changes:"
echo "   git add lib/ assets/ pubspec.yaml README.md"
echo "   git commit -m 'feat: your changes here'"
echo "   git push origin main"
echo ""
echo "🌐 Your site will be live at: https://vignaraj.dev"
echo "⏱️  Deployment typically takes 2-3 minutes"
echo ""
echo "🔍 Monitor deployment status at:"
echo "   https://github.com/vignarajj/vignarajj.github.io/actions"
echo ""
echo "💡 For local testing only, you can run:"
echo "   flutter run -d chrome --web-port=8080"
