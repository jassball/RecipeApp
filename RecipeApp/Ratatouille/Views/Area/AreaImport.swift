//
//  AreaView.swift
//  Ratatouille
//

import SwiftData
import SwiftUI

struct ImportAreasView: View {
    @AppStorage("isDarkMode") private var darkMode = false
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context

    @Query(filter: #Predicate<AreaDB>{ $0.trash == false },
           sort: \AreaDB.title, order: .forward, animation: .default) private var db: [AreaDB]

    @State private var json: [AllAreas] = []
    @State private var showSheet = false
    @State private var showAlert = false
    @State private var selectedArea: AreaDB? // State variable for selected area

    var body: some View {
        NavigationStack {
            Group {
                if db.isEmpty {
                    ContentUnavailableView("Ingen landområder registrert", systemImage: "square.stack.3d.up.slash")
                } else {
                    List(db) { area in
                        Button(action: {
                            self.selectedArea = area
                        }) {
                            AreaRow(area: area)
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        Task {
                            json = await getAllAreas()
                            showAlert.toggle()
                        }
                    } label: {
                        Image(systemName: "icloud.and.arrow.down.fill").font(.title3)
                    }
                    .alert("Vil du importere \(json.count) landområder?", isPresented: $showAlert) {
                        Button("NEI", role: .cancel) {}
                        Button("JA", role: .destructive) {
                            if !json.isEmpty {
                                for index in 0..<json.count {
                                    let area = AreaDB()
                                    area.title = json[index].strArea
                                    context.insert(area)
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
                AreaAdd()
            }
            .navigationTitle("Landområder")
        }
        .environment(\.colorScheme, darkMode ? .dark : .light)
        .sheet(item: $selectedArea) { area in
            AreaEdit(area: area)
        }
    }
}

// Preview
#Preview {
    ImportAreasView().modelContainer(for: AreaDB.self)
}

