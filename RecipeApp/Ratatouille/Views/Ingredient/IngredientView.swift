import SwiftUI
import SwiftData
struct IngredientView: View {
   
    @State private var meals = [Ingredient]()
    @State var userInput = ""
    @Query(filter: #Predicate<MealDB>{ $0.trash == false },
           sort: \MealDB.oldID, order: .forward, animation: .default) private var db: [MealDB]
    @AppStorage("isDarkMode") private var darkMode = false
  

    var body: some View {
        toolbarAndContent
    }

    
    
    
    
    
    var toolbarAndContent: some View {
        VStack {
            HStack {
            TextField("Skriv ingrediens (engelsk)", text: $userInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Søk") {
                Task {
                    meals = await getIngredients(searchQuery: userInput)
                }
            } .padding(7)
            .background(.blue)
                .foregroundStyle(.white)
                .clipShape(.buttonBorder)
            }
            ingredientContent
        }
    }
    
    var ingredientContent: some View {
        NavigationView {
            List {
                ForEach(meals, id: \.idMeal) { meal in
                    NavigationLink(destination: RecipeDetailView(id: meal.idMeal)) {
                        MealRow(meal: meal)
                    }
                }
            }
            .navigationTitle("Måltider")
            .task {
                meals = await getIngredients(searchQuery: userInput)
            }
        }
        .environment(\.colorScheme, darkMode ? .dark : .light)

    }


}


struct MealRow: View {
    var meal: Ingredient

    var body: some View {
        VStack(alignment: .center) {
            ScrollView {
                ZStack(alignment: .bottomLeading) {
                    if let imageUrl = URL(string: meal.strMealThumb) {
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
                        Text(meal.strMeal)
                            .font(.headline)
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black.opacity(0.5))
                    .cornerRadius(6)
                }
            }

        }

    }
}



#Preview {
    IngredientView()
}
