import SwiftData
import SwiftUI

struct CategoryImport: View {
    @AppStorage("isDarkMode") private var darkMode = false
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context

    @Query(filter: #Predicate<CategoryDB>{ $0.trash == false },
           sort: \CategoryDB.title, order: .forward, animation: .default) private var db: [CategoryDB]

    @State private var json: [Category] = []
    @State private var showSheet = false
    @State private var showAlert = false
    @State private var selectedCategory: CategoryDB? // State variable for selected category

    var body: some View {
        NavigationStack {
            Group {
                if db.isEmpty {
                    ContentUnavailableView("Ingen kategorier registrert", systemImage: "square.stack.3d.up.slash")
                } else {
                    List(db) { category in
                        Button(action: {
                            self.selectedCategory = category
                        }) {
                            CategoryRow(category: category)
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        Task {
                            json = await getCategories()
                            showAlert.toggle()
                        }
                    } label: {
                        Image(systemName: "icloud.and.arrow.down.fill").font(.title3)
                    }
                    .alert("Vil du importere \(json.count) kategorier?", isPresented: $showAlert) {
                        Button("NEI", role: .cancel) {}
                        Button("JA", role: .destructive) {
                            if !json.isEmpty {
                                for index in 0..<json.count {
                                    let category = CategoryDB()
                                    category.title = json[index].strCategory
                                    context.insert(category)
                                }
                            }
                        }
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showSheet.toggle()
                    } label: {
                        Image(systemName: "plus.circle.fill").font(.title3)
                    }
                }
            }
            .sheet(isPresented: $showSheet) {
                CategoryAdd()
            }
            .navigationTitle("Kategorier")
        }
        .environment(\.colorScheme, darkMode ? .dark : .light)
        .sheet(item: $selectedCategory) { category in
            CategoryEdit(category: category)
        }
    }
}

// Preview
#Preview {
    CategoryImport().modelContainer(for: CategoryDB.self)
}

