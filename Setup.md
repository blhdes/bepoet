# Poetry Generator — Setup Guide (macOS / Xcode)

## Prerequisites
- Mac with Apple Silicon (M1/M2/M3) or Intel
- Xcode 15+ (latest stable recommended)
- iOS Simulator (comes bundled with Xcode) or a physical iPhone/iPad

---

## 1. Clone the Repository

Open Terminal on your Mac and run:

```bash
# Option A: SSH (recommended, if you have SSH keys set up)
git clone git@github.com:blhdes/bepoet.git
cd bepoet

# Option B: HTTPS
git clone https://github.com/blhdes/bepoet.git
cd bepoet
```

The repo contains:
```
PoetryGenerator/
├── Models/
│   └── Haiku.swift
├── ViewModels/
│   └── HaikuViewModel.swift
├── Views/
│   ├── ContentView.swift
│   ├── HaikuComposerView.swift
│   ├── ExportView.swift
│   └── SavedHaikusView.swift
├── Utilities/
│   ├── SyllableCounter.swift
│   ├── SyllableCounterTests.swift
│   └── HaikuStorage.swift
├── Resources/
│   └── cmudict-0.7b
├── README.md
├── Setup.md                ← this file
└── PoetryGeneratorApp.swift ← app entry point
```

---

## 2. Create the Xcode Project

Since the source files were authored outside Xcode, you'll need to wrap them in an Xcode project:

1. Launch Xcode → **File → New → Project**
2. Select **iOS → App** → click Next
3. Configure:
   - **Product Name:** `PoetryGenerator`
   - **Interface:** SwiftUI
   - **Language:** Swift
   - **Team:** select your Apple developer team (or "None")
   - **Organization Identifier:** `com.yourname`
4. Save it in the `PoetryGenerator/` directory (the same folder as the source files)

---

## 3. Add Source Files to the Project

The Xcode project wizard creates placeholder files. Replace/integrate the cloned source:

1. In the Xcode navigator (left sidebar), **delete** the placeholder `ContentView.swift` and `YourProjectNameApp.swift` if present
2. **Drag and drop** the following folders from Finder into the Xcode navigator:
   - `Models/`
   - `ViewModels/`
   - `Views/`
   - `Utilities/`
   - `Resources/`
3. When prompted, check **"Copy items if needed"** and add them to the PoetryGenerator target
4. Open `Resources/` in Xcode → right-click the folder → **Add Files to "PoetryGenerator"** → select `cmudict-0.7b` → ensure your target is checked
5. In **Resources → cmudict-0.7b → File Inspector** → ensure **Target Membership** includes PoetryGenerator

---

## 4. Set the App Entry Point

Open `PoetryGeneratorApp.swift` and confirm it looks like this:

```swift
import SwiftUI

@main
struct PoetryGeneratorApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
```

Make sure:
- The `@main` attribute is on the `App` struct
- The struct name matches the **Target name** in Xcode (Project → General → Identity → Name)
- `ContentView` is the root view (it is — our ContentView uses TabView for navigation)

---

## 5. Build & Run on Simulator

1. Select an iOS Simulator (iPhone 15 / iPhone 16 simulator recommended)
   - **Xcode → Window → Devices and Simulators** to manage simulators
2. Click the **Play** button (or press `Cmd + R`)
3. The simulator launches and the app opens automatically

If you see build errors:
- Check that **all .swift files are marked in Target Membership**
- Verify the **minimum iOS deployment target** (set to iOS 17.0 or newer in Project → General)

---

## 6. Test the App

### Haiku Composer
- Tap "Compose Haiku" in the tab bar
- Enter three lines of text
- Syllable counts appear above each line (real-time as you edit)
- The submit button is enabled only when format is correct (5-7-5)
- Submitting saves the haiku and resets the composer

### Saved Haikus
- Navigate to "Saved Haikus" tab
- See your saved haikus presented in traditional format
- Tap "Edit" for deletion options

### Export
- Select a saved haiku
- Choose Export
- Copies the formatted haiku to clipboard
- Opens the system share sheet for further sharing

---

## 7. Test on a Real iPhone

1. Connect your iPhone via USB
2. On iPhone: **Settings → General → Device Management** → trust your developer certificate
3. In Xcode, select your physical device as the run destination
4. Press `Cmd + R` to install and launch

---

## 8. Running Unit Tests

The syllable counter has a unit test suite:

1. Open `Utilities/SyllableCounterTests.swift` in Xcode
2. Click the **diamond play** icon next to `test_syllableCount()` 
3. Or run all tests via: **Product → Test** (`Cmd + U`)

Expected results:
- SyllableCounter should correctly count: cat(1), water(2), beautiful(3), understanding(5)
- Words not in CMU dictionary fall back to heuristic rules
- Edge cases (empty strings, punctuation-only) return 0

---

## Troubleshooting

| Issue | Fix |
|-------|-----|
| `@main` struct name doesn't match target | Rename `PoetryGeneratorApp` to match target name, or vice versa |
| `cmudict-0.7b` not found at runtime | Ensure the file is added to Target Membership and bundled in Copy Bundle Resources |
| Build error: "Cannot find Haiku in scope" | Verify Models/Haiku.swift is in the target membership |
| Simulator shows blank screen | Check that ContentView is set as the root in the @main scene |
| Tests fail on dictionary loading | The CMU dictionary needs to be in the app bundle — check Copy Bundle Resources phase |

---

## Development Workflow (Linux → Mac sync)

Since development happens on Linux and testing on Mac:

1. **Work on Linux:** edit Swift files, update logic
2. **Commit & push:**
   ```bash
   git add -A && git commit -m "description" && git push
   ```
3. **Pull on Mac:**
   ```bash
   cd bepoet && git pull
   ```
4. The Xcode project file (`.xcodeproj/`) lives on the Mac and should NOT be committed (it's platform-specific). Add `.xcodeproj/` to `.gitignore`.

If `SyllableCounter.swift` or any utility changes, just pull on the Mac and rebuild — no project changes needed.

---

## Notes

- The CMU dictionary is ~28KB and bundled with the app — it loads at startup into memory
- `HaikuStorage` uses `UserDefaults` — it's the simplest persistence for an MVP. We may move to SwiftData later
- The app is iOS-only (no iPad, no macOS targets configured yet)
- Minimum deployment: iOS 17.0+
