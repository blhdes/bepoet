import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = HaikuViewModel()
    @State private var showingExportSheet = false
    @State private var showingSaveAlert = false
    @State private var showingSavedHaikus = false
    @State private var savedHaikus: [Haiku] = []
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                HaikuComposerView(viewModel: viewModel)
                
                Divider()
                
                HStack {
                    Button(action: {
                        // Clear action
                        viewModel.clear()
                    }) {
                        Label("Clear", systemImage: "trash")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)
                    
                    Button(action: {
                        if viewModel.isHaikuComplete {
                            let haiku = viewModel.saveHaiku()
                            HaikuStorage.shared.save(haiku)
                            savedHaikus = HaikuStorage.shared.loadAll()
                            showingSaveAlert = true
                        }
                    }) {
                        Label("Save", systemImage: viewModel.isHaikuComplete ? "checkmark.circle.fill" : "checkmark.circle")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(!viewModel.isHaikuComplete)
                    
                    Button(action: {
                        showingExportSheet = true
                    }) {
                        Label("Export", systemImage: "square.and.arrow.up")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)
                }
                .padding()
                .background(Color(.systemBackground))
            }
            .navigationTitle("Haiku Composer")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingSavedHaikus = true
                    }) {
                        Image(systemName: "book.fill")
                    }
                }
            }
            .alert("Haiku Saved!", isPresented: $showingSaveAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("Your haiku has been saved to your collection.")
            }
            .sheet(isPresented: $showingExportSheet) {
                if let haiku = viewModel.isHaikuComplete ? viewModel.saveHaiku() : nil {
                    ExportView(haiku: haiku)
                }
            }
            .sheet(isPresented: $showingSavedHaikus) {
                SavedHaikusView(haikus: $savedHaikus)
            }
            .onAppear {
                savedHaikus = HaikuStorage.shared.loadAll()
            }
        }
        .accentColor(.primary)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}