#!/bin/zsh

# Manual Deployment Script for Flutter Web Portfolio
# This builds locally and commits in smaller chunks to avoid GitHub push limits

set -e

echo "🚀 Manual Flutter Web Deployment"
echo "=================================="

# Step 1: Clean and build
echo "🧹 Cleaning previous builds..."
flutter clean
rm -f main.dart.js* flutter.js flutter_bootstrap.js index.html manifest.json version.json flutter_service_worker.js
rm -rf canvaskit/ icons/ build/

echo "📦 Getting dependencies..."
flutter pub get

echo "🏗️ Building Flutter web (release)..."
flutter build web --release --base-href "/" --dart-define=ENVIRONMENT=production

# Step 2: Verify build
if [ ! -d "build/web" ] || [ ! -f "build/web/index.html" ]; then
    echo "❌ Build failed! build/web directory or index.html not found."
    exit 1
fi

echo "✅ Build successful!"
echo "📊 Build size: $(du -sh build/web/ | cut -f1)"

# Step 3: Backup existing files
BACKUP_DIR="backup_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

# Files to backup
FILES_TO_BACKUP=("index.html" "manifest.json" "main.dart.js" "flutter.js" "flutter_bootstrap.js" "version.json" "flutter_service_worker.js")
DIRS_TO_BACKUP=("canvaskit" "icons")

for file in "${FILES_TO_BACKUP[@]}"; do
    if [ -e "$file" ]; then
        mv "$file" "$BACKUP_DIR/" 2>/dev/null || true
    fi
done

for dir in "${DIRS_TO_BACKUP[@]}"; do
    if [ -d "$dir" ]; then
        mv "$dir" "$BACKUP_DIR/" 2>/dev/null || true
    fi
done

if [ "$(ls -A $BACKUP_DIR 2>/dev/null)" ]; then
    echo "💾 Backed up existing files to $BACKUP_DIR/"
fi

# Step 4: Copy new build files
echo "📋 Copying build files to root..."
cp -R build/web/* .

# Step 5: Optimize for Git (handle large files)
echo "🔧 Optimizing files for Git..."

# Check file sizes and split large commits if needed
LARGE_FILES=()
for file in *.js; do
    if [ -f "$file" ] && [ $(stat -f%z "$file" 2>/dev/null || stat -c%s "$file" 2>/dev/null) -gt 2000000 ]; then
        LARGE_FILES+=("$file")
    fi
done

if [ ${#LARGE_FILES[@]} -gt 0 ]; then
    echo "⚠️  Large files detected: ${LARGE_FILES[*]}"
    echo "📝 Will commit in multiple smaller chunks to avoid push errors..."
fi

# Step 6: Commit strategy
echo "🔄 Committing changes..."

# First, commit small files
git add web/ assets/ lib/ pubspec.yaml CNAME favicon.ico manifest.json index.html version.json 2>/dev/null || true
git add flutter_service_worker.js 2>/dev/null || true

if [ "$(git diff --cached --name-only)" ]; then
    git commit -m "deploy: Update web assets and configuration

- Updated web/index.html template  
- Updated manifest.json and configuration files
- Ready for Flutter web deployment"
    
    echo "✅ Committed configuration files"
    
    # Push small files first
    echo "📤 Pushing configuration changes..."
    git push origin main || echo "⚠️  Push failed, continuing..."
fi

# Then handle JavaScript files separately
if [ -f "flutter.js" ]; then
    echo "📤 Adding Flutter framework files..."
    git add flutter.js flutter_bootstrap.js 2>/dev/null || true
    
    if [ "$(git diff --cached --name-only)" ]; then
        git commit -m "deploy: Add Flutter framework files"
        echo "📤 Pushing framework files..."
        git push origin main || echo "⚠️  Framework files push failed"
    fi
fi

# Handle the large main bundle
if [ -f "main.dart.js" ]; then
    echo "📤 Adding main application bundle..."
    git add main.dart.js* 2>/dev/null || true
    
    if [ "$(git diff --cached --name-only)" ]; then
        git commit -m "deploy: Add main application bundle"
        echo "📤 Pushing main bundle (this may take time)..."
        
        # Try multiple times with different strategies
        for attempt in 1 2 3; do
            echo "🔄 Push attempt $attempt/3..."
            if git push origin main; then
                echo "✅ Main bundle pushed successfully!"
                break
            else
                echo "⚠️  Attempt $attempt failed, trying again..."
                sleep 2
            fi
        done
    fi
fi

# Finally, add any remaining files
echo "📤 Adding remaining files..."
git add canvaskit/ icons/ 2>/dev/null || true

if [ "$(git diff --cached --name-only)" ]; then
    git commit -m "deploy: Add CanvasKit and icons"
    echo "📤 Pushing remaining files..."
    git push origin main || echo "⚠️  Final push failed"
fi

# Step 7: Clean up
rm -rf build/

echo "✅ Manual deployment completed!"
echo "🌐 Your site should be live at: https://vignaraj.dev"
echo "⏱️  Changes may take 2-5 minutes to appear due to CDN caching"
echo ""
echo "💡 To verify deployment:"
echo "   1. Wait 2-5 minutes"
echo "   2. Visit https://vignaraj.dev"
echo "   3. Force refresh: Cmd+Shift+R (Mac) or Ctrl+F5 (Windows)"