# Poetry Generator (iOS)

## Vision

A native iOS poetry app that helps you become a better poet. No AI, no generators — just structured guidance, real-time feedback, and progressive learning. You are the poet.

## Current State

**MVP Phase 1:** Haiku composer with progressive form support.

- Syllable counting with CMU Pronouncing Dictionary accuracy
- Centered, minimalist writing interface designed for concentration
- Real-time syllable feedback per line (no colored borders, no checkmarks)
- Educational guidance for each poetic form
- Save, export, and manage your collection

**Planned Forms (progressive difficulty):**
1. **Haiku** (5·7·5) — Japanese tradition — Difficulty: 1
2. **Tanka** (5·7·5·7·7) — Japanese court poetry — Difficulty: 2
3. **Cinquain** (2·4·6·8·2) — Adelaide Crapsey — Difficulty: 3
4. **Limerick** (8·8·5·5·8) — English/Irish folk — Difficulty: 3
5. **Sonnet** (14×10) — Italian/English tradition — Difficulty: 5

## Project Structure

PoetryGenerator/

| Directory | Purpose |
|-----------|---------|
| `Models/` | Data models (`Haiku`, `PoeticForm`) |
| `ViewModels/` | View state managers (`ComposerViewModel`) |
| `Views/` | SwiftUI views (`ComposerView`, `SavedHaikusView`, `ExportView`) |
| `Utilities/` | Tools (`SyllableCounter`, `HaikuStorage`, tests) |
| `Resources/` | Bundled assets (CMU Pronouncing Dictionary) |

## Features

### Composer View
- Clean, centered text fields for each line
- Small syllable counter below each line (shows target when empty, actual count when typing)
- Form name + subtitle header at the top
- Educational guidance section at the bottom
- Info button to learn about the current form

### Saved Haikus
- View your collected haikus in a clean list
- Delete individual haikus with swipe-to-remove
- Theme and mood tags shown when available

### Export
- Copy haiku as text to clipboard
- Share as a formatted image via system share sheet

## Setup

See [Setup.md](Setup.md) for detailed instructions on building and testing in Xcode.

**Quick version:**
1. Clone: `git clone git@github.com:blhdes/bepoet.git`
2. Create an Xcode iOS project in the PoetryGenerator directory
3. Add source files to the target
4. Build and run on iPhone Simulator or physical device

## Tech Stack

- SwiftUI (iOS 17+)
- Combine for reactive syllable counting
- CMU Pronouncing Dictionary for accurate syllable counting
- UserDefaults for persistence (placeholder — SwiftData planned for later)

## License

Private project. All rights reserved.
