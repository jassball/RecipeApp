//
//  AreaAdd.swift
//  Ratatouille
//

import SwiftUI

struct IngredientAdd: View {
    @AppStorage("isDarkMode") private var darkMode = false
    @Environment(\.dismiss) private var dismiss
    
    @Environment(\.modelContext) private var context
    
    @State private var title = ""
    @State private var countrycode = ""
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Ingrediens", text: $title)
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Avbryt", role: .cancel) {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    Text("Ny ingrediens")
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Lagre") {
                        let ingredient = IngredientDB()
                        
                        ingredient.title = title
                        
                        context.insert(ingredient)
                        dismiss()
                    }
                    .disabled(title.isEmpty)
                }
            }
        }
        .environment(\.colorScheme, darkMode ? .dark : .light)
        .presentationDetents([.height(250), .medium])
        .presentationCornerRadius(20)
    }
}

#Preview {
    IngredientAdd()
}

