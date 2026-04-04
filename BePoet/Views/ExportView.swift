import SwiftUI

struct ExportView: View {
    let haiku: Haiku
    @Environment(\.dismiss) var dismiss
    @State private var showingActivityView = false
    @State private var exportedImage: UIImage? = nil
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Your Haiku")
                .font(.title2)
                .fontWeight(.semibold)
            
            VStack(alignment: .leading, spacing: 12) {
                Text(haiku.line1)
                    .font(.title3)
                Text(haiku.line2)
                    .font(.title3)
                Text(haiku.line3)
                    .font(.title3)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
            
            if let theme = haiku.theme {
                HStack {
                    Image(systemName: "tag")
                    Text("Theme: \(theme)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            if let mood = haiku.mood {
                HStack {
                    Image(systemName: "face.smiling")
                    Text("Mood: \(mood)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
            
            Button(action: {
                generateImage()
                showingActivityView = true
            }) {
                Label("Share as Image", systemImage: "square.and.arrow.up")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .disabled(exportedImage == nil)
            
            Button(action: {
                UIPasteboard.general.string = "\(haiku.line1)\n\(haiku.line2)\n\(haiku.line3)"
                // Show a quick toast? For simplicity, just dismiss after copy.
                dismiss()
            }) {
                Label("Copy Text", systemImage: "doc.on.clipboard")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)
        }
        .padding()
        .sheet(isPresented: $showingActivityView) {
            if let image = exportedImage {
                ActivityView(activityItems: [image])
            }
        }
    }
    
    private func generateImage() {
        // Simple image generation: render the haiku text into a UIImage
        let renderer = ImageRenderer(content: HaikuImageView(haiku: haiku))
        renderer.scale = 3.0 // For high resolution
        exportedImage = renderer.uiImage
    }
}

struct HaikuImageView: View {
    let haiku: Haiku
    
    var body: some View {
        VStack(spacing: 16) {
            Text(haiku.line1)
                .font(.title2)
            Text(haiku.line2)
                .font(.title2)
            Text(haiku.line3)
                .font(.title2)
        }
        .padding(40)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
    }
}

// ActivityView to present UIActivityViewController
struct ActivityView: UIViewControllerRepresentable {
    let activityItems: [Any]
    let applicationActivities: [UIActivity]? = nil
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

struct ExportView_Previews: PreviewProvider {
    static var previews: some View {
        ExportView(haiku: Haiku(line1: "Old pond silent", line2: "A frog jumps in— splash!", line3: "Silence again."))
    }
}