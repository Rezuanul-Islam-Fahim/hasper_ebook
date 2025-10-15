# Appetize Deployment Workflow Architecture

## 🔄 Workflow Overview

```
┌─────────────────────────────────────────────────────────────────┐
│                     TRIGGER EVENT                                │
│  (Pull Request to master or Manual dispatch)                    │
└────────────────────────┬────────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│                    SETUP ENVIRONMENT                             │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐         │
│  │ Checkout     │  │ Setup Java   │  │ Setup Flutter │         │
│  │ Repository   │→ │ JDK 17 (Zulu)│→ │ 3.35.6 Stable│         │
│  └──────────────┘  └──────────────┘  └──────────────┘         │
└────────────────────────────┬────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│                    RESTORE CACHES                                │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐         │
│  │ Flutter SDK  │  │ Pub Cache    │  │ Gradle Cache │         │
│  │ Cache        │  │              │  │              │         │
│  └──────────────┘  └──────────────┘  └──────────────┘         │
│                                                                  │
│  Cache Hit?  YES → Fast Build (3-5 min)                        │
│              NO  → Full Build (10-15 min)                       │
└────────────────────────────┬────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│                  FIREBASE CONFIGURATION                          │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐         │
│  │ Install      │→ │ Install      │→ │ Configure    │         │
│  │ Firebase CLI │  │ FlutterFire  │  │ Firebase     │         │
│  └──────────────┘  └──────────────┘  └──────────────┘         │
│                                              │                   │
│  Generates: firebase_options.dart, google-services.json, etc.   │
└────────────────────────────┬────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│                    BUILD PROCESS                                 │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐         │
│  │ flutter      │→ │ flutter pub  │→ │ flutter      │         │
│  │ doctor -v    │  │ get          │  │ analyze      │         │
│  └──────────────┘  └──────────────┘  └──────────────┘         │
│                                              │                   │
│                                              ▼                   │
│                                    ┌──────────────┐             │
│                                    │ flutter build│             │
│                                    │ apk --release│             │
│                                    └──────────────┘             │
└────────────────────────────┬────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│                    POST-BUILD ACTIONS                            │
│  ┌──────────────┐  ┌──────────────┐                            │
│  │ Rename APK   │→ │ Upload as    │                            │
│  │ with Version │  │ Artifact     │                            │
│  └──────────────┘  └──────────────┘                            │
│                                                                  │
│  APK Name: hasper_ebook-{VERSION}.apk (from pubspec.yaml)       │
│  Retention: 30 days                                             │
└────────────────────────────┬────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│                APPETIZE DEPLOYMENT LOGIC                         │
│                                                                  │
│  Check: Does APPETIZE_PUBLIC_KEY exist?                         │
│                                                                  │
│  ┌───────────────────────┐    ┌──────────────────────┐         │
│  │ NO (First Time)       │    │ YES (Update)         │         │
│  │                       │    │                      │         │
│  │ ┌─────────────────┐   │    │ ┌────────────────┐  │         │
│  │ │ POST /v1/apps   │   │    │ │ POST           │  │         │
│  │ │ (New Upload)    │   │    │ │ /v1/apps/{key} │  │         │
│  │ └────────┬────────┘   │    │ └────────┬───────┘  │         │
│  │          │            │    │          │          │         │
│  │          ▼            │    │          ▼          │         │
│  │ ┌─────────────────┐   │    │ ┌────────────────┐  │         │
│  │ │ Get Public Key  │   │    │ │ Update Existing│  │         │
│  │ │ Display Warning │   │    │ │ App            │  │         │
│  │ └─────────────────┘   │    │ └────────────────┘  │         │
│  └───────────────────────┘    └──────────────────────┘         │
└────────────────────────────┬────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│                    GENERATE OUTPUTS                              │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐         │
│  │ Workflow     │  │ PR Comment   │  │ Deployment   │         │
│  │ Summary      │  │ (if PR)      │  │ Info         │         │
│  └──────────────┘  └──────────────┘  └──────────────┘         │
│                                                                  │
│  Contains:                                                       │
│  • Build information                                            │
│  • APK download link                                            │
│  • Public key                                                   │
│  • App URL for testing                                          │
│  • Setup instructions (if first time)                           │
└─────────────────────────────────────────────────────────────────┘
```

## 📦 Caching Strategy

```
┌──────────────────────────────────────────────────────────────┐
│                      CACHE LAYERS                             │
└──────────────────────────────────────────────────────────────┘

Layer 1: Flutter SDK Cache
├── Location: ${{ runner.tool_cache }}/flutter
├── Key: flutter-:os:-:channel:-:version:-:arch:-:hash:
├── Size: ~800 MB
└── Saves: 2-3 minutes per build

Layer 2: Pub Dependencies Cache  
├── Location: ~/.pub-cache, .dart_tool
├── Key: ${{ runner.os }}-pub-${{ hashFiles('**/pubspec.lock') }}
├── Size: ~100-500 MB
└── Saves: 1-2 minutes per build

Layer 3: Gradle Dependencies Cache
├── Location: ~/.gradle/caches, ~/.gradle/wrapper, ~/.android/build-cache
├── Key: ${{ runner.os }}-gradle-${{ hashFiles('**/*.gradle*', 'gradle-wrapper.properties') }}
├── Size: ~500 MB - 1 GB
└── Saves: 3-5 minutes per build

Layer 4: Java Distribution Cache
├── Location: Managed by setup-java action
├── Key: Auto-managed
├── Size: ~200 MB
└── Saves: 30-60 seconds per build

Total Time Saved: 7-11 minutes on subsequent builds!
```

## 🔐 Secret Management

```
┌──────────────────────────────────────────────────────────────┐
│                    GITHUB SECRETS                             │
└──────────────────────────────────────────────────────────────┘

Required Secrets:
┌─────────────────────────┐
│ FIREBASE_TOKEN          │  ← Required for Firebase config
│                         │    (Get via: firebase login:ci)
│ FIREBASE_PROJECT_ID     │  ← Your Firebase project ID
│                         │    (e.g., hasper-ebook)
│ APPETIZE_API_TOKEN      │  ← Required for Appetize deploy
│                         │    (Get from Appetize.io)
└─────────────────────────┘

Optional (After First Deployment):
┌─────────────────────────┐
│ APPETIZE_PUBLIC_KEY     │  ← Add after first successful run
│                         │    (Provided in workflow output)
└─────────────────────────┘

Secret Usage Flow:
1. Workflow authenticates with Firebase using FIREBASE_TOKEN
2. Configures Firebase for all platforms using FIREBASE_PROJECT_ID
3. Reads APPETIZE_API_TOKEN for Appetize authentication
4. Checks if APPETIZE_PUBLIC_KEY exists
   ├── NO  → Creates new app, returns public key
   └── YES → Updates existing app using public key
```

## 🎯 Decision Tree

```
                    Start Workflow
                         │
                         ▼
         ┌───────────────────────────┐
         │ Is APPETIZE_PUBLIC_KEY    │
         │ defined in secrets?       │
         └──────────┬────────────────┘
                    │
          ┌─────────┴─────────┐
          │                   │
         NO                  YES
          │                   │
          ▼                   ▼
   ┌────────────┐      ┌────────────┐
   │ NEW UPLOAD │      │   UPDATE   │
   └──────┬─────┘      └─────┬──────┘
          │                   │
          ▼                   ▼
   ┌────────────┐      ┌────────────┐
   │ POST       │      │ POST       │
   │ /v1/apps   │      │ /v1/apps/  │
   │            │      │ {key}      │
   └──────┬─────┘      └─────┬──────┘
          │                   │
          ▼                   ▼
   ┌────────────┐      ┌────────────┐
   │ Receive    │      │ Keep same  │
   │ new public │      │ public key │
   │ key        │      │            │
   └──────┬─────┘      └─────┬──────┘
          │                   │
          ▼                   ▼
   ┌────────────┐      ┌────────────┐
   │ Show       │      │ Confirm    │
   │ warning to │      │ successful │
   │ save key   │      │ update     │
   └────────────┘      └────────────┘
```

## 📊 Build Timeline Comparison

```
First Build (No Cache):
┌────────────────────────────────────────────────────────────┐
│ Checkout           ████ 30s                                │
│ Setup Java         ██████████ 60s                          │
│ Setup Flutter      ████████████████████ 120s               │
│ Firebase Config    ████████████ 75s                        │
│ Flutter Doctor     ████ 20s                                │
│ Pub Get            ████████████ 80s                        │
│ Analyze            ████ 30s                                │
│ Gradle Build       ████████████████████████████ 180s       │
│ Flutter Build      ████████████████████████████████ 200s   │
│ Appetize Upload    ████████ 45s                            │
└────────────────────────────────────────────────────────────┘
Total: ~14 minutes

Subsequent Build (With Cache):
┌────────────────────────────────────────────────────────────┐
│ Checkout           ████ 30s                                │
│ Setup Java         ██ 15s (cached)                         │
│ Setup Flutter      ████ 25s (cached)                       │
│ Firebase Config    ██████ 35s                              │
│ Flutter Doctor     ██ 10s                                  │
│ Pub Get            ██ 15s (cached)                         │
│ Analyze            ██ 10s                                  │
│ Gradle Build       ████████ 45s (cached)                   │
│ Flutter Build      ████████████████ 90s                    │
│ Appetize Upload    ████████ 45s                            │
└────────────────────────────────────────────────────────────┘
Total: ~5.5 minutes

⚡ Speed Improvement: ~2.5x faster!
```

## 🔄 Continuous Deployment Flow

```
Developer                GitHub Actions              Appetize.io
    │                          │                         │
    │  Push Code / Create PR  │                         │
    ├────────────────────────►│                         │
    │                          │                         │
    │                          │  Build APK             │
    │                          ├──────────┐             │
    │                          │          │             │
    │                          │◄─────────┘             │
    │                          │                         │
    │                          │  Upload/Update APK     │
    │                          ├────────────────────────►│
    │                          │                         │
    │                          │  Return Public Key +   │
    │                          │  App URL               │
    │                          │◄────────────────────────┤
    │                          │                         │
    │  Workflow Complete      │                         │
    │  (Summary + Artifact)   │                         │
    │◄────────────────────────┤                         │
    │                          │                         │
    │                                                    │
    │  Test App in Browser                              │
    ├───────────────────────────────────────────────────►│
    │                                                    │
```

## 🏗️ Project Context

### Application Architecture

**Hasper eBook** is a Flutter-based digital library application using Firebase backend:

- **Frontend:** Flutter with Material Design
- **State Management:** Provider pattern
- **Database:** Cloud Firestore (book catalog and metadata)
- **Storage:** Firebase Storage (PDF files)
- **PDF Viewing:** Syncfusion Flutter PDF Viewer
- **Platforms:** Android, iOS, Web

### Key Features Tested

The Appetize deployment allows testing of:

- ✅ Book browsing and search functionality
- ✅ Infinite scroll pagination
- ✅ PDF viewing and navigation
- ✅ Book details and metadata display
- ✅ Real-time Firestore data synchronization
- ✅ Responsive layouts across devices

### Firebase Integration

The workflow builds an APK that connects to Firebase services:

- **Firestore:** Stores book catalog, metadata, and user data
- **Storage:** Hosts PDF files for viewing
- **Security Rules:** Pre-configured for production use

### Dependencies

**Core Packages:**
- `cloud_firestore: ^5.6.0` - Firestore database integration
- `firebase_core: ^3.15.0` - Firebase initialization
- `provider: ^6.1.2` - State management
- `syncfusion_flutter_pdfviewer: ^28.2.12` - PDF rendering
- `infinite_scroll_pagination: ^4.1.0` - Paginated lists
- `flutter_svg: ^2.0.16` - SVG asset support

## 📝 Setup Instructions

### Step 1: Get Firebase CI Token

1. Install Firebase CLI locally:
   ```bash
   npm install -g firebase-tools
   ```

2. Login and get CI token:
   ```bash
   firebase login:ci
   ```

3. Copy the token that appears

### Step 2: Get Appetize API Token

1. Go to [Appetize.io](https://appetize.io/)
2. Create an account or sign in
3. Navigate to Account Settings → API Token
4. Copy your API token

### Step 3: Add GitHub Secrets

1. Go to your repository: `Settings → Secrets and variables → Actions`
2. Click **New repository secret**
3. Add the following secrets:

   **FIREBASE_TOKEN**
   - **Name:** `FIREBASE_TOKEN`
   - **Value:** Your Firebase CI token from Step 1

   **FIREBASE_PROJECT_ID**
   - **Name:** `FIREBASE_PROJECT_ID`
   - **Value:** `hasper-ebook`

   **APPETIZE_API_TOKEN**
   - **Name:** `APPETIZE_API_TOKEN`
   - **Value:** Your Appetize API token from Step 2

### Step 4: First Workflow Run

1. Create a Pull Request to the `master` branch
2. Or manually trigger the workflow: `Actions → Build Flutter APK and Deploy to Appetize → Run workflow`
3. Wait for the workflow to complete
4. Check the workflow summary for the public key

### Step 5: Save Public Key (First Time Only)

After the first successful run:

1. Copy the public key from the workflow summary
2. Go to `Settings → Secrets and variables → Actions`
3. Click **New repository secret**
4. Add:
   - **Name:** `APPETIZE_PUBLIC_KEY`
   - **Value:** The public key from step 1

### Step 6: Subsequent Runs

For all future runs:

- The workflow will automatically update the existing Appetize app
- No need to update the public key again
- Each build will be available at the same URL

## 🔍 Troubleshooting

### Build Failures

**Issue:** Gradle build fails
- **Solution:** Check `android/app/build.gradle` for correct SDK versions
- **Solution:** Verify Firebase secrets (`FIREBASE_TOKEN` and `FIREBASE_PROJECT_ID`) are set correctly
- **Note:** Project uses compileSdk 36 and targetSdk 36

**Issue:** Firebase configuration fails
- **Solution:** Ensure `FIREBASE_TOKEN` and `FIREBASE_PROJECT_ID` secrets are set in GitHub
- **Solution:** Verify Firebase project ID is `hasper-ebook`
- **Solution:** Check Firebase CLI authentication by reviewing workflow logs
- **Solution:** Ensure all Firebase app IDs are correctly configured in firebase.json

**Issue:** Flutter analyze fails
- **Solution:** Run `flutter analyze` locally and fix linting issues
- **Note:** Workflow continues even if analysis fails (`continue-on-error: true`)

**Issue:** APK not found after build
- **Solution:** Verify pubspec.yaml version format: `version: 1.0.0+1`

**Issue:** Syncfusion license error
- **Solution:** Ensure Syncfusion PDF Viewer license is properly configured
- **Note:** Free community license available for applications with <$1M revenue

### Appetize Upload Failures

**Issue:** API token invalid
- **Solution:** Verify `APPETIZE_API_TOKEN` secret is correct
- **Solution:** Check if token has expired (regenerate if needed)

**Issue:** Public key not working
- **Solution:** Verify `APPETIZE_PUBLIC_KEY` secret matches the key from first upload
- **Solution:** Try removing the secret and letting workflow create new app

**Issue:** Upload timeout
- **Solution:** Check network connectivity
- **Solution:** Verify APK size is within Appetize limits (~100 MB)
- **Note:** PDF viewer library can increase APK size significantly

### Cache Issues

**Issue:** Slow builds despite caching
- **Solution:** Clear GitHub Actions cache: `Settings → Actions → Caches`
- **Solution:** Manually trigger workflow after clearing cache

**Issue:** Outdated dependencies
- **Solution:** Update `pubspec.lock` and push changes
- **Solution:** Cache key will automatically update based on lock file hash

## 🎯 Workflow Optimization Tips

1. **Keep dependencies updated:** Regularly update Flutter and package versions
2. **Minimize APK size:** Use `flutter build apk --split-per-abi` for smaller builds
3. **Optimize assets:** Compress icons and images before committing
4. **Use semantic versioning:** Follow semver in pubspec.yaml for clear version tracking
5. **Test locally first:** Run `flutter build apk --release` before pushing
6. **Monitor Syncfusion updates:** Keep PDF viewer library updated for bug fixes

## 📈 Monitoring and Metrics

### Workflow Metrics to Track

- **Build Duration:** Target < 5 minutes with cache
- **APK Size:** Monitor size growth over time (baseline ~40-50 MB with PDF viewer)
- **Cache Hit Rate:** Aim for >80% cache hits
- **Failure Rate:** Target <5% build failures

### Where to Find Metrics

- **Build times:** GitHub Actions → Workflow runs → Individual job times
- **APK size:** Build artifacts → Download and check file size
- **Cache performance:** Workflow logs → Cache restore/save steps

## 🔒 Security Considerations

### Firebase Configuration

- **Never commit:** `google-services.json` with production keys
- **Use separate projects:** Development vs. Production Firebase projects
- **Firestore rules:** Review security rules before production deployment
- **API keys:** Restrict Firebase API keys to specific platforms

### Secrets Management

- **Rotate regularly:** Change Firebase and Appetize tokens periodically
- **Limit access:** Only add secrets that are necessary
- **Monitor usage:** Check GitHub Actions logs for unauthorized access attempts

### APK Distribution

- **Appetize apps:** Are publicly accessible if someone has the URL
- **Artifact retention:** 30 days (automatically deleted after)
- **Production builds:** Use separate workflow for Play Store releases

### PDF Content Security

- **Storage rules:** Configure Firebase Storage rules for PDF access control
- **Content protection:** Consider implementing PDF encryption for sensitive content
- **User authentication:** Implement if restricting access to certain books

## 📚 Application-Specific Notes

### PDF Viewer Considerations

- **Large files:** Syncfusion PDF Viewer handles large PDFs efficiently
- **Memory management:** Monitor memory usage for multiple PDF loads
- **Offline support:** Consider caching frequently accessed PDFs

### Infinite Scroll Performance

- **Page size:** Optimize Firestore query limit for smooth scrolling
- **Image loading:** Lazy load book cover images
- **State persistence:** Save scroll position for better UX

### Firestore Query Optimization

- **Indexing:** Ensure proper composite indexes for complex queries
- **Pagination:** Use cursor-based pagination for efficient data fetching
- **Real-time listeners:** Minimize active listeners to reduce costs

---

**Architecture Version:** 1.0.0  
**Last Updated:** October 2025  
**Flutter Version:** 3.35.6  
**Dart SDK:** ^3.5.0  
**Java Version:** 17 (Zulu Distribution)  
**Target SDK:** Android 36  
**Minimum SDK:** Android 21 (Android 5.0 Lollipop)  
**Firebase Project:** hasper-ebook  
**Package Name:** com.rezuanulfahim.hasper_ebook
