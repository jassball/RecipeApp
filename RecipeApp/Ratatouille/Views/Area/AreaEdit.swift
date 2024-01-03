//
//  AreaEdit.swift
//  Ratatouille
//

import SwiftUI

struct AreaEdit: View {
    @Bindable var area: AreaDB
    
    @AppStorage("isDarkMode") private var darkMode = false
    @Environment(\.dismiss) private var dismiss
    
    @State private var title = ""
    @State private var countrycode = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Landområde", text: $title)
                TextField("Land kode", text: $countrycode)
                
                Section {
                    Text("Opprettet: \(area.create.formatted(date: .abbreviated, time: .standard))")
                    Text("Sist endret: \(area.update.formatted(date: .abbreviated, time: .standard))")
                }
                .foregroundStyle(.secondary)
            }
            .onAppear {
                print("hello")
                title = area.title
                countrycode = area.countrycode
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
                        area.title = title
                        area.countrycode = countrycode.uppercased()
                        area.update = Date.now
                        
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

