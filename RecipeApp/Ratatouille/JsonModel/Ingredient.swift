//
//  MealDB.swift
//  Ratatouille


import Foundation
import SwiftData



struct IngredientResponse: Decodable {
    var meals: [Ingredient]
}

struct Ingredient: Decodable {
    var strMeal: String
    var strMealThumb: String
    var idMeal: String
    
    init(idMeal: String, strMeal: String, strCategory: String, strArea: String, strMealThumb: String) {
        self.idMeal = idMeal
        self.strMeal = strMeal
        self.strMealThumb = strMealThumb
    }
}

struct getAllIngredientResponse: Decodable {
    var meals: [AllIngredients]
}

struct AllIngredients: Decodable, Hashable {
    var idIngredient: String
    var strIngredient: String
    
    init(idIngredient: String, strIngredient: String) {
        self.idIngredient = idIngredient
        self.strIngredient = strIngredient
    }
}

func getIngredients(searchQuery: String) async -> [Ingredient] {
    
    let encodedQuery = searchQuery.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    
    let urlString = "https://www.themealdb.com/api/json/v1/1/filter.php?i=\(encodedQuery)"
    
    guard let connection = URL(string: urlString) else {
        print("Invalid URL")
        return []
    }
    
    do {
        let (data, _) = try await URLSession.shared.data(from: connection)
        let response = try JSONDecoder().decode(IngredientResponse.self, from: data)
        return response.meals
    }
    catch {
        print("Error fetching data: \(error)")
        return []
    }
}

func getAllIngredients() async -> [AllIngredients] {
    
    let collectAllUrlString = "https://www.themealdb.com/api/json/v1/1/list.php?i=list"
    
    guard let connection = URL(string: collectAllUrlString) else {
        print("Invalid URL")
        return []
    }
    do {
        let (data, _) = try await URLSession.shared.data(from: connection)
        let response = try JSONDecoder().decode(getAllIngredientResponse.self, from: data)
        return response.meals
    } catch  {
        print("Error fetching data: \(error)")
        return []
    }
}


struct DetailedMealResponse: Decodable {
    var meals: [DetailedMeal]
}

struct DetailedMeal: Decodable {
    var idMeal: String
    var strMeal: String
    var strCategory: String
    var strArea: String
    var strMealThumb: String
    var strInstructions: String
    
    init(idMeal: String, strMeal: String, strCategory: String, strArea: String, strMealThumb: String, strInstructions: String) {
        self.idMeal = idMeal
        self.strMeal = strMeal
        self.strCategory = strCategory
        self.strArea = strArea
        self.strMealThumb = strMealThumb
        self.strInstructions = strInstructions
    }
}

func getMealDetails(idMeal: String) async -> DetailedMeal? {
    let detailsUrlString = "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(idMeal)"

    guard let connection = URL(string: detailsUrlString) else {
        print("Invalid URL")
        return nil
    }

    do {
        let (data, _) = try await URLSession.shared.data(from: connection)
        let response = try JSONDecoder().decode(DetailedMealResponse.self, from: data)
        return response.meals.first
    } catch {
        print("Error fetching detailed data: \(error)")
        return nil
    }
}




