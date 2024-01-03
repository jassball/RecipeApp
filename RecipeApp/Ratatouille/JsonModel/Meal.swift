//
//  MealDB.swift
//  Ratatouille

import Foundation

struct Meals : Decodable {
  let meals: [Meal]
}

struct Meal : Decodable, Identifiable {
  var id: String
  {
    idMeal ?? UUID().uuidString
  }
  
  let idMeal: String?
  let strMeal: String?
  let strMealThumb: String?
  let strCategory: String?
  let strArea: String?
  let strInstructions: String?
  let strTags: String?
  let strMeasure1: String?
  let strMeasure2: String?
  let strMeasure3: String?
  let strMeasure4: String?
  let strMeasure5: String?
  let strMeasure6: String?
  let strMeasure7: String?
  let strMeasure8: String?
  let strMeasure9: String?
  let strMeasure10: String?
  let strMeasure11: String?
  let strMeasure12: String?
  let strMeasure13: String?
  let strMeasure14: String?
  let strMeasure15: String?
  let strMeasure16: String?
  let strMeasure17: String?
  let strMeasure18: String?
  let strMeasure19: String?
  let strMeasure20: String?
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    let strIngredient10: String?
    let strIngredient11: String?
    let strIngredient12: String?
    let strIngredient13: String?
    let strIngredient14: String?
    let strIngredient15: String?
    let strIngredient16: String?
    let strIngredient17: String?
    let strIngredient18: String?
    let strIngredient19: String?
    let strIngredient20: String?
}

func getMeals(searchQuery: String) async -> [Meal] {
    
    let encodedQuery = searchQuery.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    
    let urlString = "https://www.themealdb.com/api/json/v1/1/search.php?s=\(encodedQuery)"
    
    guard let connection = URL(string: urlString) else {
        print("Invalid URL")
        return []
    }
    
    do {
        let (data, _) = try await URLSession.shared.data(from: connection)
        let response = try JSONDecoder().decode(Meals.self, from: data)
        return response.meals
    }
    catch {
        print("Error fetching data: \(error)")
        return []
    }
}

func getMeal(url: String) async -> [Meal]
{
  // Prøver å opprette kontakt med API server
  guard let connection = URL(string: url) else
  {
    // Returnerer tom tabell på grunn av feil
    return [Meal]()
  }
  
  do
  {
    // Prøver å laste ned data fra serveren og ignorerer metadata ved hjelp av UNDERSCORE
    let (data, _) = try await URLSession.shared.data(from: connection)
    
    // Dekoder data i samsvar med tabellstruktur og returnerer disse data
    return try JSONDecoder().decode(Meals.self, from: data).meals
  }
  catch
  {
    print(error)
    
    // Returnerer tom tabell på grunn av feil under nedlasting eller dekoding av data
    return [Meal]()
  }
}

