//
//  AreaView.swift
//  Ratatouille
//

import SwiftData
import SwiftUI

struct MyRecepiesImport: View {
    @AppStorage("isDarkMode") private var darkMode = false
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context

    @Query(filter: #Predicate<MealDB>{ $0.trash == false },
           sort: \MealDB.title, order: .forward, animation: .default) private var meals: [MealDB]

    @State private var json: [AllAreas] = []
    @State private var showSheet = false
    @State private var showAlert = false
    @State private var selectedMeal: MealDB? // State variable for selected area

    var body: some View {
        NavigationStack {
            Group {
                if meals.isEmpty {
                    ContentUnavailableView("Ingen oppkrifter er lagret", systemImage: "square.stack.3d.up.slash")
                } else {
                    List(meals) { meal in
                        Button(action: {
                            self.selectedMeal = meal
                        }) {
                            MyRecepiesRow(meal: meal)
                        }
                    }
                }
            }
            .navigationTitle("Lagrede oppskrifter")
        }
        .environment(\.colorScheme, darkMode ? .dark : .light)
        .sheet(item: $selectedMeal) { meal in
            MyRecepiesEdit(meals: meal)
        }
    }
}

// Preview
#Preview {
    MyRecepiesView().modelContainer(for: MealDB.self)
}


