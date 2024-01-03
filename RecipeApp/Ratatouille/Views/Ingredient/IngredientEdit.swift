//
//  AreaEdit.swift
//  Ratatouille
//

import SwiftUI

struct IngredientEdit: View {
    @Bindable var ingredient: IngredientDB
    
    @AppStorage("isDarkMode") private var darkMode = false
    @Environment(\.dismiss) private var dismiss
    
    @State private var title = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Ingredients:", text: $title)
                
                Section {
                    Text("Opprettet: \(ingredient.create.formatted(date: .abbreviated, time: .standard))")
                    Text("Sist endret: \(ingredient.update.formatted(date: .abbreviated, time: .standard))")
                }
                .foregroundStyle(.secondary)
            }
            .onAppear {
                print("hello")
                title = ingredient.title
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Avbryt", role: .cancel) {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    Text("Redigere landområde")
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Lagre") {
                        ingredient.title = title
                        ingredient.update = Date.now
                        
                        dismiss()
                    }
                    .disabled(title.isEmpty)
                }
            }
        }
        .environment(\.colorScheme, darkMode ? .dark : .light)
        .navigationBarBackButtonHidden()
    }
}

