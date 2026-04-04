import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ComposerViewModel()
    @State private var haikus: [Haiku] = HaikuStorage.shared.loadAll()

    var body: some View {
        TabView {
            NavigationStack {
                ComposerView(viewModel: viewModel)
                    .navigationTitle("Compose")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Label("Compose", systemImage: "pencil")
            }

            SavedHaikusView(haikus: $haikus)
                .tabItem {
                    Label("Saved", systemImage: "books.vertical")
                }
        }
    }
}
