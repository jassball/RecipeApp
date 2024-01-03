//
//  CategoryEdit.swift
//  Ratatouille
//

import SwiftUI

struct CategoryEdit: View {
    @Bindable var category: CategoryDB
    
    @AppStorage("isDarkMode") private var darkMode = false
    @Environment(\.dismiss) private var dismiss
    
    @State private var title = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Kategori", text: $title)
                
                Section {
                    Text("Opprettet: \(category.create.formatted(date: .abbreviated, time: .standard))")
                    Text("Sist endret: \(category.update.formatted(date: .abbreviated, time: .standard))")
                }
                .foregroundStyle(.secondary)
            }
            .onAppear {
                print("hello")
                title = category.title
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
                        category.title = title
                        category.update = Date.now
                        
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

