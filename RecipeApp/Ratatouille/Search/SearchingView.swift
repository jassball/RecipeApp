import SwiftUI

struct SearchingView: View {
    @State private var meals = [Meal]()
    @State var userInput = ""
    @AppStorage("isDarkMode") private var darkMode = false


    var body: some View {
        VStack {
            HStack {
                
          
            TextField("Søk", text: $userInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Søk") {
                Task {
                    meals = await getMeals(searchQuery: userInput)
                }
            }
            .padding(7)
            .background(.blue)
                .foregroundStyle(.white)
                .clipShape(.buttonBorder)
            }
            searchContent
        }
    }
    
    var searchContent: some View {
        NavigationView {
            List(meals, id: \.idMeal) { meal in
                NavigationLink(destination: RecipeDetailView(id: meal.idMeal ?? "")) {
                    VStack(alignment: .center) {
                        ScrollView {
                            ZStack(alignment: .bottomLeading) {
                                // Image
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
                                
                                // Text with background
                                VStack(alignment: .leading) {
                                    Text(meal.strMeal ?? "")
                                        .font(.headline)
                                    Text(meal.strCategory ?? "")
                                        .font(.subheadline)
                                    Text(meal.strArea ?? "")
                                        .font(.subheadline)
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
            .navigationTitle("Måltider")
            .task {
                meals = await getMeals(searchQuery: userInput)
            }
        }
        .environment(\.colorScheme, darkMode ? .dark : .light)
    }
}


#Preview {
    SearchingView()

}



