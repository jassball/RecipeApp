import SwiftUI
import SwiftData

struct CategoryView: View {
    @Binding var meals: [Meal]
    @Query(filter: #Predicate<CategoryDB> { $0.trash == false },
           sort: \CategoryDB.title, order: .forward, animation: .default) private var categories: [CategoryDB]
    @State private var selectedCategory = "Velg Kategori"
    @AppStorage("isDarkMode") private var darkMode = false

    var body: some View {
        toolbarAndContent
    }
    
    
    
    
    var toolbarAndContent: some View {
        NavigationView {
            VStack {
                HStack {
                    
            
                    Menu {
                        if categories.isEmpty {
                            Text("Du må importere i instillinger")
                        } else {
                            Picker("Velg Kategori", selection: $selectedCategory) {
                                ForEach(categories, id: \.self) { category in
                                    Text(category.title).tag(category.title)
                                }
                            }
                        }
                    } label: {
                        Text(selectedCategory)
                            .foregroundColor(.blue)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                    }
                    
                    Button("Søk") {
                        Task {
                            meals = await getMeal(url: "https://www.themealdb.com/api/json/v1/1/filter.php?c=\(selectedCategory)")
                        }
                    }
                    .padding()
                }

                categoryContent
            }
        }
    }

    var categoryContent: some View {
        NavigationView {
            List(meals, id: \.idMeal) { meal in
                NavigationLink(destination: RecipeDetailView(id: meal.id)) {
                    VStack(alignment: .center) {
                        ScrollView {
                            ZStack(alignment: .bottomLeading) {
                                if let imageUrl = URL(string: meal.strMealThumb ?? "") {
                                    AsyncImage(url: imageUrl) { image in
                                        image.resizable()
                                            .aspectRatio(contentMode: .fill)
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .frame(width: 300, height: 150)
                                    .cornerRadius(10)
                                    .clipped()
                                }

                                VStack(alignment: .leading) {
                                    Text(meal.strMeal ?? "")
                                        .font(.headline)
                                }
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.black.opacity(0.5))
                                .cornerRadius(10)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Kategori").font(.subheadline)
        }
        .environment(\.colorScheme, darkMode ? .dark : .light)
    }
}


