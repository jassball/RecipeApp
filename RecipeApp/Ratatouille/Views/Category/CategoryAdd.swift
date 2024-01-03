//
//  CategoryAdd.swift
//  Ratatouille
//

import SwiftUI

struct CategoryAdd: View {
    @AppStorage("isDarkMode") private var darkMode = false
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    @State private var title = ""
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Kategori", text: $title)
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Avbryt", role: .cancel) {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    Text("Ny kategori")
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Lagre") {
                        let category = CategoryDB()
                        
                        category.title = title
                        
                        context.insert(category)
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

#Preview
{
  CategoryAdd()
}

