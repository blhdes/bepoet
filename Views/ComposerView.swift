import SwiftUI

// MARK: - Composer View

struct ComposerView: View {
    @ObservedObject var viewModel: ComposerViewModel
    @State private var showingFormGuide = false

    var body: some View {
        ScrollView {
            VStack(spacing: 28) {
                formHeader

                Divider()

                VStack(spacing: 0) {
                    ForEach(Array(viewModel.lines.enumerated()), id: \.offset) { index, line in
                        if index > 0 { Spacer(minLength: 20) }

                        ComposerLineView(
                            text:Binding(
                                get: { viewModel.lines[index] },
                                set: { viewModel.updateLine(at: index, with: $0) }
                            ),
                            syllableCount: viewModel.syllableCounts[index],
                            target: viewModel.activeForm.lineCounts[index],
                            isValid: viewModel.lineIsValid(at: index)
                        )
                    }
                }
                .padding(.horizontal, 28)
                .padding(.top, 8)

                Divider()

                guidanceSection
            }
            .padding(.top, 12)
            .padding(.bottom, 32)
        }
        .sheet(isPresented: $showingFormGuide) {
            FormGuideSheet(form: viewModel.activeForm)
        }
    }

    // MARK: - Form Header

    private var formHeader: some View {
        VStack(spacing: 4) {
            HStack {
                Text(viewModel.activeForm.name)
                    .font(.title3.weight(.medium))
                Text(viewModel.activeForm.subtitle)
                    .font(.callout)
                    .foregroundColor(.secondary)
                    .fontWeight(.semibold)
                    .monospacedDigit()
                Spacer()
                Button {
                    showingFormGuide = true
                } label: {
                    Image(systemName: "info.circle")
                        .foregroundColor(.secondary)
                }
            }
            .padding(.horizontal, 28)
        }
    }

    // MARK: - Guidance Section

    private var guidanceSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(viewModel.activeForm.id == "haiku" ? "Haiku Guidance" : "Guidance")
                    .font(.caption.weight(.semibold))
                    .foregroundColor(.secondary)
                    .textCase(.uppercase)
                    .tracking(0.5)
                Spacer()
            }

            Text(viewModel.activeForm.description)
                .font(.callout)
                .foregroundColor(.secondary)

            if viewModel.activeForm.id == "haiku" {
                VStack(alignment: .leading, spacing: 6) {
                    bullet("Observe a single moment, not a story")
                    bullet("Include a seasonal reference (kigo)")
                    bullet("Let two images speak to each other")
                }
                .padding(.top, 4)
            }
        }
        .padding(.horizontal, 28)
    }

    private func bullet(_ text: String) -> some View {
        HStack(alignment: .top, spacing: 6) {
            Image(systemName: "circle.fill")
                .font(.system(size: 4))
                .frame(width: 8)
                .foregroundColor(.secondary)
                .padding(.top, 6)
            Text(text)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}

// MARK: - Composer Line View

struct ComposerLineView: View {
    @Binding var text: String
    var syllableCount: Int
    var target: Int
    var isValid: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            TextField("", text: $text, axis: .vertical)
                .font(.body)
                .multilineTextAlignment(.center)
                .disableAutocorrection(true)
                .autocapitalization(.never)
                .submitLabel(.next)
                .lineLimit(1)
                .background(Color.clear)

            HStack(spacing: 6) {
                Spacer()
                if text.isEmpty {
                    Text("\(target) syllables")
                        .font(.caption2.monospacedDigit())
                        .foregroundColor(.tertiary)
                } else {
                    Text("\(syllableCount)")
                        .font(.caption.monospacedDigit())
                        .fontWeight(isValid ? .medium : .regular)
                        .foregroundColor(isValid ? .secondary : .red)
                    Text("/")
                        .font(.caption2)
                        .foregroundColor(.tertiary)
                    Text("\(target)")
                        .font(.caption.monospacedDigit())
                        .foregroundColor(.tertiary)
                }
            }
        }
        .padding(.vertical, 8)
    }
}

// MARK: - Form Guide Sheet

struct FormGuideSheet: View {
    let form: PoeticForm
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Text(form.name)
                        .font(.title2.weight(.semibold))
                    Text(form.subtitle)
                        .font(.title3.weight(.medium))
                        .foregroundColor(.secondary)
                    Spacer()
                }
                
                VStack(alignment: .leading, spacing: 6) {
                    Text("Origin")
                        .font(.caption.weight(.medium))
                        .foregroundColor(.secondary)
                        .textCase(.uppercase)
                        .tracking(0.5)
                    Text(form.origin)
                        .font(.body)
                }
                
                VStack(alignment: .leading, spacing: 6) {
                    Text("Description")
                        .font(.caption.weight(.medium))
                        .foregroundColor(.secondary)
                        .textCase(.uppercase)
                        .tracking(0.5)
                    Text(form.description)
                        .font(.body)
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("About This Form")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }
}

// MARK: - Preview

#Preview {
    ComposerView(viewModel: ComposerViewModel())
}
