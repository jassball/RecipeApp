//
//  MealView.swift
//  Ratatouille
//

import SwiftUI

struct RecipeDetailView: View {
  var id: String
  
  @Environment(\.dismiss) private var dismiss
  @Environment(\.modelContext) private var context
  
  @State private var meals: [Meal] = []
  @State private var ingredients = "Ingen ingredienser"
  @State private var showAlert = false
@AppStorage("isDarkMode") private var darkMode = false


  
  var body: some View
  {
    NavigationStack
    {
        Form {
            
            if let imageUrl = URL(string: meals.first?.strMealThumb ?? "") {
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
            Section("Område - Kategori") {
            
            
                HStack {
          Image(systemName: "globe.europe.africa")
            Text(meals.first?.strArea ?? "")
          Divider()
          Image(systemName: "character.book.closed.fill")
          Text(meals.first?.strCategory ?? "Ukjent")
        }
            }
        .foregroundStyle(.secondary)
        
        Section("Instruksjoner")
        {
          Text(meals.first?.strInstructions ?? "Ingen instrukser")
        }
        
        Section("Ingredienser")
        {
          Text(ingredients)
        }
        }
        
      }
      .toolbar {
        
        ToolbarItem(placement: .topBarTrailing) {
            
          Button
          {
            let meal = MealDB()
            meal.oldID = meals.first?.idMeal ?? "Ukjent"
            meal.title = meals.first?.strMeal ?? "Ukjent"
            meal.instructions = meals.first?.strInstructions ?? "Ukjent"
            meal.ingredients = ingredients
            meal.thumb = meals.first?.strMealThumb ?? ""
            context.insert(meal)
            
            showAlert = true
          }
          label:
          {
            Image(systemName: "square.and.arrow.down.on.square.fill")
          }
          .alert("Oppskriften er lagret i databasen.", isPresented: $showAlert) {}
          .disabled(meals.isEmpty)
        }
      }
      .task
      {
        meals = await getMeal(url: "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(id)")
        
        if !meals.isEmpty {
          var ingredient: String
          
          ingredient = (meals.first?.strIngredient1 ?? "") + ": " + (meals.first?.strMeasure1 ?? "")
          ingredients = (ingredient == ": ") ? "" : ingredient + "\n"
          
          ingredient = (meals.first?.strIngredient2 ?? "") + ": " + (meals.first?.strMeasure2 ?? "")
          ingredients += (ingredient == ": ") ? "" : ingredient + "\n"
          
          ingredient = (meals.first?.strIngredient3 ?? "") + ": " + (meals.first?.strMeasure3 ?? "")
          ingredients += (ingredient == ": ") ? "" : ingredient + "\n"
          
          ingredient = (meals.first?.strIngredient4 ?? "") + ": " + (meals.first?.strMeasure4 ?? "")
          ingredients += (ingredient == ": ") ? "" : ingredient + "\n"
          
          ingredient = (meals.first?.strIngredient5 ?? "") + ": " + (meals.first?.strMeasure5 ?? "")
          ingredients += (ingredient == ": ") ? "" : ingredient + "\n"
          
          ingredient = (meals.first?.strIngredient6 ?? "") + ": " + (meals.first?.strMeasure6 ?? "")
          ingredients += (ingredient == ": ") ? "" : ingredient + "\n"
          
          ingredient = (meals.first?.strIngredient7 ?? "") + ": " + (meals.first?.strMeasure7 ?? "")
          ingredients += (ingredient == ": ") ? "" : ingredient + "\n"
          
          ingredient = (meals.first?.strIngredient8 ?? "") + ": " + (meals.first?.strMeasure8 ?? "")
          ingredients += (ingredient == ": ") ? "" : ingredient + "\n"
          
          ingredient = (meals.first?.strIngredient9 ?? "") + ": " + (meals.first?.strMeasure9 ?? "")
          ingredients += (ingredient == ": ") ? "" : ingredient + "\n"
          
          ingredient = (meals.first?.strIngredient10 ?? "") + ": " + (meals.first?.strMeasure10 ?? "")
          ingredients += (ingredient == ": ") ? "" : ingredient + "\n"
        }
      }
      .navigationTitle(meals.first?.strMeal ?? "Ukjent tittel")
      .environment(\.colorScheme, darkMode ? .dark : .light)
    }
  
}

#Preview {
  RecipeDetailView(id: "52772")
}

