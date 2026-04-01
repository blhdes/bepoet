import SwiftUI

struct HaikuComposerView: View {
    @ObservedObject var viewModel: HaikuViewModel
    @State private var showingThemeModal = false
    @State private var showingMoodModal = false
    
    var body: some View {
        VStack(spacing: 24) {
            // Theme and Mood selectors
            HStack {
                Button(action: { showingThemeModal = true }) {
                    HStack {
                        Image(systemName: "doc.text")
                        Text(viewModel.theme.isEmpty ? "Theme" : viewModel.theme)
                            .lineLimit(1)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                }
                
                Button(action: { showingMoodModal = true }) {
                    HStack {
                        Image(systemName: "face.smiling")
                        Text(viewModel.mood.isEmpty ? "Mood" : viewModel.mood)
                            .lineLimit(1)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                }
            }
            .sheet(isPresented: $showingThemeModal) {
                ThemeSelectorView(selectedTheme: $viewModel.theme)
            }
            .sheet(isPresented: $showingMoodModal) {
                MoodSelectorView(selectedMood: $viewModel.mood)
            }
            
            // Haiku lines
            VStack(spacing: 16) {
                HaikuLineView(text: $viewModel.line1,
                              syllableCount: viewModel.line1SyllableCount,
                              target: 5,
                              isValid: viewModel.line1Valid,
                              lineNumber: 1)
                
                HaikuLineView(text: $viewModel.line2,
                              syllableCount: viewModel.line2SyllableCount,
                              target: 7,
                              isValid: viewModel.line2Valid,
                              lineNumber: 2)
                
                HaikuLineView(text: $viewModel.line3,
                              syllableCount: viewModel.line3SyllableCount,
                              target: 5,
                              isValid: viewModel.line3Valid,
                              lineNumber: 3)
            }
            .padding(.horizontal)
            
            // Educational tooltip (optional)
            DisclosureGroup("Haiku Guidance") {
                VStack(alignment: .leading, spacing: 8) {
                    Text("A traditional haiku consists of 3 lines with a 5-7-5 syllable pattern.")
                    Text("Focus on a moment in nature or a simple observation.")
                    Text("Try to include a seasonal reference (kigo) if you can.")
                    Text("The juxtaposition of two ideas creates the haiku's insight.")
                }
                .font(.footnote)
                .foregroundColor(.secondary)
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .padding(.horizontal)
        }
        .padding()
    }
}

struct HaikuLineView: View {
    @Binding var text: String
    var syllableCount: Int
    var target: Int
    var isValid: Bool
    var lineNumber: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("Line \(lineNumber)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Spacer()
                Text("\(syllableCount)/\(target)")
                    .font(.subheadline.monospaced())
                    .fontWeight(.medium)
                    .foregroundColor(isValid ? .green : .red)
            }
            
            TextField("", text: $text, axis: .vertical)
                .font(.body)
                .padding(12)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .strokeBorder(isValid ? Color.green.opacity(0.3) : Color.red.opacity(0.3),
                                      lineWidth: 1)
                        .background(Color(.systemBackground))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .strokeBorder(isValid ? Color.green : Color.red, lineWidth: 1)
                )
                .lineLimit(5...10)
                .disableAutocorrection(true)
                .autocapitalization(.sentences)
        }
    }
}

// Placeholder views for Theme and Mood selectors (to be implemented)
struct ThemeSelectorView: View {
    @Binding var selectedTheme: String
    @Environment(\.dismiss) var dismiss
    
    let commonThemes = ["Nature", "Seasons", "Love", "Loss", "Journey", "Stillness", "Water", "Sky", "Earth", "City"]
    
    var body: some View {
        NavigationView {
            List {
                Section("Common Themes") {
                    ForEach(commonThemes, id: \.self) { theme in
                        Button(action: {
                            selectedTheme = theme
                            dismiss()
                        }) {
                            HStack {
                                Text(theme)
                                Spacer()
                                if selectedTheme == theme {
                                    Image(systemName: "checkmark")
                                }
                            }
                        }
                    }
                }
                
                Section("Custom Theme") {
                    TextField("Enter your theme", text: $selectedTheme)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                }
            }
            .navigationTitle("Theme")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }
}

struct MoodSelectorView: View {
    @Binding var selectedMood: String
    @Environment(\.dismiss) var dismiss
    
    let moods = ["Tranquil", "Joyful", "Melancholic", "Energetic", "Reflective", "Hopeful", "Lonely", "Peaceful", "Mysterious", "Nostalgic"]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(moods, id: \.self) { mood in
                    Button(action: {
                        selectedMood = mood
                        dismiss()
                    }) {
                        HSText {
                            Text(mood)
                            Spacer()
                            if selectedMood == mood {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                }
            }
            .navigationTitle("Mood")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }
}