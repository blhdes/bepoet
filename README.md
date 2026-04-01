# Poetry Generator

An elegant and simple iOS app that helps users compose haiku (and eventually other poetic forms) by providing structural guidance, educational context, and a beautiful writing interface - without generating content for them.

## Vision

To be a tool that educates and guides users in writing poetry themselves, fostering creativity and learning through constraint-based assistance.

## Current Focus (MVP)

- Haiku composition with 5-7-5 syllable guidance
- Real-time syllable counting and validation
- Theme and mood selection for inspiration
- Educational tooltips about haiku principles
- Export/share haiku as text or image
- Save and revisit favorite haiku

## Project Structure

```
PoetryGenerator/
├── Models/
│   └── Haiku.swift
├── Views/
│   ├── ContentView.swift
│   ├── HaikuComposerView.swift
│   ├── ExportView.swift
│   └── SavedHaikusView.swift
├── ViewModels/
│   └── HaikuViewModel.swift
├── Utilities/
│   ├── SyllableCounter.swift
│   └── HaikuStorage.swift
└── Resources/
    (Assets, etc. to be added)
```

## Features in Detail

### Haiku Composer
- Three-line input with real-time syllable counting (targets: 5, 7, 5)
- Visual feedback (green/red) for syllable count validity
- Optional theme and mood input for inspiration
- Educational disclosure group with haiku guidelines

### Export & Sharing
- Share as beautifully typeset image (via `UIActivityViewController`)
- Copy as text to clipboard
- Export options for image sharing

### Saved Haikus
- Persistent storage using `UserDefaults` (via `HaikuStorage` singleton)
- View, edit (by reopening in composer), and delete saved haikus
- Timestamped for chronological viewing

## Technical Implementation

### Syllable Counting
- Uses a simple vowel-group heuristic (with silent 'e' removal) for English words
- Can be improved with a pronunciation dictionary (like CMU) for greater accuracy
- Updates in real-time as user types (with debouncing)

### Data Persistence
- `HaikuStorage` class handles saving/loading array of `Haiku` structs to `UserDefaults`
- `Haiku` model is `Codable` for easy JSON serialization

### SwiftUI
- MVVM-like architecture with `HaikuViewModel` managing form state and validation
- Reusable `HaikuLineView` for each line of the haiku
- Modular sheets for theme/mood selection, export, and saved haikus list

## Next Steps

1. **Refine syllable counting**: Integrate a more accurate dictionary-based approach.
2. **Add more poetic forms**: After haiku is solid, implement tanka, cinquain, etc.
3. **Enhance UI/UX**: 
   - Animated feedback when line is valid/invalid
   - Seasonal word (kigo) suggestions
   - Cutting word (kireji) examples for English haiku
4. **Localization**: Support multiple languages (starting with Spanish and Japanese).
5. **Community features**: Optional anonymous sharing of haiku for inspiration.
6. **Challenges & prompts**: Daily haiku themes or writing exercises.

## Dependencies

- Swift 5.5+
- iOS 15.0+
- No third-party dependencies (uses only SwiftUI and Foundation)

## Notes for Development

- This project was started in a Linux environment where Swift is not available for compilation.
- To build and run, open the `PoetryGenerator` directory in Xcode on a Mac.
- The code is written to be compatible with SwiftUI's lifecycle and data flow.

## Tags

#ios #swiftui #poetry #haiku #mvp #educational-app #creative-writing