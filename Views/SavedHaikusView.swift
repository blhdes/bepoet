import SwiftUI

struct SavedHaikusView: View {
    @Binding var haikus: [Haiku]
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    @State private var offsetToDelete: IndexSet? = nil
    
    var body: some View {
        NavigationView {
            List {
                if haikus.isEmpty {
                    Text("No saved haikus yet")
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, alignment: .center)
                } else {
                    ForEach(haikus) { haiku in
                        VStack(alignment: .leading, spacing: 8) {
                            Text(haiku.line1)
                                .font(.title3)
                            Text(haiku.line2)
                                .font(.title3)
                            Text(haiku.line3)
                                .font(.title3)
                            
                            if let theme = haiku.theme, !theme.isEmpty {
                                HStack {
                                    Image(systemName: "tag")
                                    Text(theme)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            }
                            
                            if let mood = haiku.mood, !mood.isEmpty {
                                HStack {
                                    Image(systemName: "face.smiling")
                                    Text(mood)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            }
                            
                            Text(haiku.timestamp, style: .date)
                                .font(.caption2)
                                .foregroundColor(.secondary)
                        }
                        .padding(.vertical, 4)
                    }
                    .onDelete { indexSet in
                        offsetToDelete = indexSet
                        showingDeleteAlert = true
                    }
                }
            }
            .navigationTitle("My Haikus")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Done") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
            .alert("Delete Haiku?", isPresented: $showingDeleteAlert) {
                Button("Delete", role: .destructive) {
                    if let offset = offsetToDelete {
                        HaikuStorage.shared.delete(at: offset, from: &haikus)
                    }
                }
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("Are you sure you want to delete this haiku? This action cannot be undone.")
            }
        }
    }
}

struct SavedHaikusView_Previews: PreviewProvider {
    static var previews: some View {
        SavedHaikusView(haikus: .constant([
            Haiku(line1: "Old pond silent", line2: "A frog jumps in— splash!", line3: "Silence again."),
            Haiku(line1: "Cherry blossoms", line2: "Fall like pink snow on the river", line3: "Swift current carries")
        ]))
    }
}