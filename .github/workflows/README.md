# 🚀 CI/CD Workflows for Flutter Web Portfolio

This directory contains GitHub Actions workflows for automated building, testing, and deployment of the Flutter web portfolio.

## 📋 Available Workflows

### 1. `deploy.yml` - Simple Deployment
**Trigger**: Push to `main` branch  
**Purpose**: Basic build and deploy workflow

**Features:**
- ✅ Flutter web build with release optimization
- ✅ Automated deployment to GitHub Pages
- ✅ Basic static analysis
- ✅ Simple error handling

### 2. `ci-cd.yml` - Advanced CI/CD Pipeline
**Trigger**: Push to `main`/`develop`, Manual dispatch  
**Purpose**: Comprehensive CI/CD with multiple quality gates

**Features:**
- 🔍 Smart change detection (only runs when Flutter files change)
- 📊 Code formatting validation
- 🧪 Automated testing with coverage reports
- 🛡️ Security scanning placeholder
- 📈 Bundle size analysis
- 🎯 Multi-environment support
- 📝 Detailed deployment summaries
- 💾 Build artifact caching


## 🔧 Setup Instructions

### 1. Enable GitHub Pages
1. Go to your repository **Settings** → **Pages**
2. Set **Source** to "GitHub Actions"
3. The workflows will automatically deploy to your custom domain (if CNAME is configured)

### 2. Repository Permissions
The workflows require these permissions (automatically configured):
- `contents: read` - Access repository code
- `pages: write` - Deploy to GitHub Pages
- `id-token: write` - OIDC authentication for deployment
- `actions: read` - Access workflow status

### 3. Flutter Version Configuration
The workflows use Flutter `3.24.3` (stable). To update:

```yaml
env:
  FLUTTER_VERSION: "3.24.3"  # Update this version
```

### 4. Custom Domain Setup
If using a custom domain:
1. Add your domain to the `CNAME` file in the repository root
2. Configure DNS settings with your domain provider
3. The workflows will automatically respect the CNAME configuration

## 📊 Workflow Behavior

### Main Branch (`main`)
- ✅ Full CI/CD pipeline runs
- ✅ Deploys to GitHub Pages on success
- 📊 Comprehensive quality checks
- 📈 Performance monitoring

### Development Branch (`develop`)
- ✅ Build and test validation
- ❌ No deployment (validation only)
- 🔍 Change detection optimizations


## 🛠️ Customization Options

### Environment Variables
```yaml
env:
  FLUTTER_VERSION: "3.24.3"
  NODE_VERSION: "18"
  DART_DEFINE_ENV: "production"
```

### Build Configuration
```yaml
- name: Build Flutter Web
  run: |
    flutter build web \
      --release \
      --web-renderer html \
      --base-href "/" \
      --source-maps \
      --dart-define=ENVIRONMENT=production \
      --dart-define=API_URL=${{ secrets.API_URL }}
```

### Security Scanning
Add security tools in the `security-scan` job:
```yaml
- name: Security Scan
  run: |
    # Example: Add SAST scanning
    # npm install -g @security/scanner
    # security-scanner --path .
```

## 🔍 Monitoring & Debugging

### Workflow Logs
- Check **Actions** tab in GitHub repository
- Each step shows detailed logs
- Failed runs include error context

### Build Artifacts
- Web builds are uploaded as artifacts
- Retained for 30 days
- Download from workflow run page

### Deployment Status
- Check deployment status in **Environments** tab
- View deployment history and rollback options
- Monitor live site availability

## 📈 Performance Considerations

### Caching Strategy
- ✅ Flutter SDK caching
- ✅ Pub dependency caching
- ✅ Build artifact caching
- 📊 Cache hit rate monitoring

### Build Optimization
- 🎯 HTML renderer for better compatibility
- 📦 Source maps for debugging
- 🗜️ Automatic compression via GitHub Pages
- ⚡ CDN distribution

## 🚨 Troubleshooting

### Common Issues

**Build Fails on Dependencies**
```bash
# Clear pub cache and retry
flutter clean
flutter pub get
```

**Deployment Fails**
- Check repository permissions
- Verify GitHub Pages is enabled
- Confirm CNAME file is correct

**Analysis Warnings**
- Run `flutter analyze` locally
- Fix linting issues before push
- Consider adjusting analysis_options.yaml

### Support
For issues with these workflows:
1. Check workflow logs in Actions tab
2. Review Flutter and GitHub Pages documentation
3. Verify repository settings and permissions

---

## 📝 Workflow Status

| Workflow | Status | Last Updated |
|----------|--------|--------------|  
| Simple Deploy | [![Deploy](../../actions/workflows/deploy.yml/badge.svg)](../../actions/workflows/deploy.yml) | Latest |
| CI/CD Pipeline | [![CI/CD](../../actions/workflows/ci-cd.yml/badge.svg)](../../actions/workflows/ci-cd.yml) | Latest |

---
*🤖 These workflows are designed to be production-ready with best practices for Flutter web deployment.*