import SwiftData
import SwiftUI

struct ImportIngredientView: View {
    @AppStorage("isDarkMode") private var darkMode = false
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context

    @Query(filter: #Predicate<IngredientDB>{ $0.trash == false },
           sort: \IngredientDB.title, order: .forward, animation: .default) private var db: [IngredientDB]

    @State private var json: [AllIngredients] = []
    @State private var showSheet = false
    @State private var showAlert = false
    @State private var selectedIngredient: IngredientDB? // State variable for selected ingredient
    @State private var ingredientDelete = false
    @State private var ingredientDeleteSuccess = false

    var body: some View {
        NavigationStack {
            Group {
                if db.isEmpty {
                    ContentUnavailableView("Ingen ingredienser registrert", systemImage: "square.stack.3d.up.slash")
                } else {
                    List(db) { ingredient in
                        Button(action: {
                            self.selectedIngredient = ingredient
                        }) {
                            IngredientRow(ingredient: ingredient)
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        Task {
                            json = await getAllIngredients()
                            showAlert.toggle()
                        }
                    } label: {
                        Image(systemName: "icloud.and.arrow.down.fill").font(.title3)
                    }
                    .alert("Vil du importere \(json.count) ingredienser?", isPresented: $showAlert) {
                        Button("NEI", role: .cancel) {}
                        Button("JA", role: .destructive) {
                            if !json.isEmpty {
                                for index in 0..<json.count {
                                    let ingredient = IngredientDB()
                                    ingredient.title = json[index].strIngredient
                                    context.insert(ingredient)
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
                ToolbarItem(placement: .topBarTrailing) {
                   
                }
            }
            .sheet(isPresented: $showSheet) {
                // Implement IngredientAdd view here
            }
            .navigationTitle("Ingredienser")
        }
        .environment(\.colorScheme, darkMode ? .dark : .light)
        .sheet(item: $selectedIngredient) { ingredient in
            IngredientEdit(ingredient: ingredient)
        }
    }
}

// Preview
#Preview {
    ImportIngredientView().modelContainer(for: IngredientDB.self)
}

