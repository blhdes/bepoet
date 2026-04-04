# BePoet — Setup Guide

## Prerequisites
- Mac with Xcode 16+
- iOS Simulator (bundled with Xcode) or a physical iPhone

## Run on Simulator

1. Clone the repo: `git clone git@github.com:blhdes/bepoet.git`
2. Open `BePoet.xcodeproj` in Xcode
3. Select an iPhone simulator at the top (e.g. iPhone 16)
4. Press `Cmd+R`

## Run on a Real iPhone

1. Connect your iPhone via USB
2. Select your device as the run destination in Xcode
3. Press `Cmd+R`
4. If prompted, trust the developer certificate on your iPhone: **Settings → General → VPN & Device Management**

## Run Unit Tests

Open `BePoet/Utilities/SyllableCounterTests.swift` and press `Cmd+U`, or use **Product → Test**.

## Troubleshooting

| Issue | Fix |
|-------|-----|
| `cmudict-0.7b` not found at runtime | In Xcode, select the file → File Inspector → ensure Target Membership is checked |
| Blank screen on launch | Check that `ContentView` is set as the root in `BePoetApp.swift` |
| Build error: type not found | Ensure all folders under `BePoet/` are included in the target |

## Notes

- The CMU dictionary (~28KB) is bundled with the app and loaded at startup
- Persistence uses `UserDefaults` — SwiftData migration planned later
- iOS 17+ required
