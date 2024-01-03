import SwiftUI
import SwiftData

struct MyRecepiesEdit: View {
    @Bindable var meals: MealDB
    @Environment(\.modelContext) private var context
    
    @AppStorage("isDarkMode") private var darkMode = false
    @Environment(\.dismiss) private var dismiss
    @Query(filter: #Predicate<CategoryDB> { $0.trash == false },
           sort: \CategoryDB.title, order: .forward, animation: .default) private var categories: [CategoryDB]
    @Query(filter: #Predicate<AreaDB>{$0.trash == false},
           sort: \AreaDB.title, order: .forward, animation: .default) private var areas: [AreaDB]
    @State private var selectedCategory = "Velg Kategori"
    @State private var selectedArea = "Velg landområde"
    
    @State private var title = ""
    @State private var instructions = ""
    @State private var ingredients = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Oppskrift", text: $title)
                    .font(.title2)
    
                
                VStack {
                    Section("Ingredienser") {
                        TextField("Skriv inn", text: $ingredients, axis: .vertical)
                            .frame(height: 100)
                    }
                    
                    Divider()
                    
                    Section("Instrukser") {
                        TextField("Skriv inn", text: $instructions, axis: .vertical)
                            .frame(height: 100)
                    }
                    Section("Kategori") {
                        if categories.isEmpty {
                            Text("Du må importere kategorier")
                        } else {
                        Picker("Velg Kategori", selection: $selectedCategory) {
                            ForEach(categories, id: \.self) { category in
                                Text(category.title).tag(category.title)
                            }
                        }
                        }
                    }
                    Divider()
                    Section("Landområde") {
                        if areas.isEmpty {
                            Text("Du må importere landområder")
                        } else {
                        Picker("Velg område", selection: $selectedArea) {
                            ForEach(areas, id: \.self) { area in
                                Text(area.title).tag(area.title)
                            }
                        }
                        }
                    }
                    Divider()
                    
                    Section {
                        Text("Opprettet: \(meals.create.formatted(date: .abbreviated, time: .standard))")
                        Text("Sist endret: \(meals.update.formatted(date: .abbreviated, time: .standard))")
                    }
                    .foregroundStyle(.secondary)
                }
                .onAppear {
                    title = meals.title
                    instructions = meals.instructions
                    ingredients = meals.ingredients
                    
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Lagre") {
                            meals.title = title
                            instructions  = meals.instructions
                            ingredients = meals.ingredients
                            meals.update = Date.now
                            dismiss()
                           
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Avbryt", role: .cancel) {
                            dismiss()
                        }
                    }
                }
                .environment(\.colorScheme, darkMode ? .dark : .light)
                .navigationBarBackButtonHidden()
            }
        }
    }
    
}
