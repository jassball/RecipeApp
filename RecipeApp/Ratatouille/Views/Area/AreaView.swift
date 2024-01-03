import SwiftUI
import SwiftData
struct AreaView: View {
    @State private var flag = [Area]()
    @Binding var meals: [Meal]
    @State private var selectedArea = "Velg område"
    @Query(filter: #Predicate<AreaDB>{$0.trash == false},
           sort: \AreaDB.title, order: .forward, animation: .default) private var areas: [AreaDB]
    @AppStorage("isDarkMode") private var darkMode = false

    
    @State private var flagUrlString = ""
    
    var body: some View {
     
            VStack {
                HStack {
                    Menu {
                        if areas.isEmpty {
                            Text("Du må importere landområder i instillinger")
                        } else {
                            Picker("Velg område", selection: $selectedArea) {
                                ForEach(areas, id: \.self) { area in
                                    Text(area.title).tag(area.title)
                                }
                            }
                        }
                       
                    } label: {
                        Text(selectedArea)
                            .foregroundColor(.blue)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                    }
                    
                    Button("Søk") {
                        flagUrlString = setFlag(for: selectedArea)
                        Task {
                            flag = await getArea(searchQuery: selectedArea)
                            meals = await getMeal(url: "https://www.themealdb.com/api/json/v1/1/filter.php?a=\(selectedArea)")
                        }
                    }
                    .padding()
                
                    
                    if let url = URL(string: flagUrlString) {
                        AsyncImage(url: url) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 64, height: 64)
                        .cornerRadius(8)
                    } else {
                        Image(systemName: "flag.slash")
                            .resizable()
                            .frame(width: 64, height: 64)
                    }
                }
                .padding()
                Divider()
                
                areaContent
            }
            
    }

    
    
  
    var areaContent: some View {
        NavigationView {
            List(meals, id: \.id) { meal in
                NavigationLink(destination: RecipeDetailView(id: meal.id)) {

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
            .navigationTitle("Sortert fra land").font(.subheadline)
           
        }
        .environment(\.colorScheme, darkMode ? .dark : .light)

    }


    
}




