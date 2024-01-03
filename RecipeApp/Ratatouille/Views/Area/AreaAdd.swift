//
//  AreaAdd.swift
//  Ratatouille
//

import SwiftUI

struct AreaAdd: View {
    @AppStorage("isDarkMode") private var darkMode = false
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    @State private var title = ""
    @State private var countrycode = ""
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Landområde", text: $title)
                TextField("Land kode", text: $countrycode)
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Avbryt", role: .cancel) {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    Text("Nytt landområde")
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Lagre") {
                        let area = AreaDB()
                        
                        area.title = title
                        area.countrycode = countrycode.uppercased()
                        
                        context.insert(area)
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
    AreaAdd()
}
