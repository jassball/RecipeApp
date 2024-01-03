
import SwiftData
import SwiftUI

struct ArchiveView: View {
    @AppStorage("isDarkMode") private var darkMode = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    CategoryArchive()
                }
                .frame(height: 100)
                
                Section {
                    AreaArchive()
                }
                .frame(height: 100)
                
                Section {
                    IngredientArchive()
                }
                .frame(height: 100)
                
                Section {
                    MyRecepiesArchive()
                }
                .frame(height: 100)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.backward")
                        Text("Tilbake")
                    }
                }
            }
            .navigationTitle("Arkiv")
        }
        .environment(\.colorScheme, darkMode ? .dark : .light)
    }
}
