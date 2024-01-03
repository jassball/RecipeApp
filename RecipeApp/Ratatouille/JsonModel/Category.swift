
//
//  MealDB.swift
//  Ratatouille
import Foundation
import SwiftData


struct CategoryResponse: Decodable {
    var categories: [Category]
}

struct Category: Decodable, Hashable {
    var strCategoryThumb: String
    var idCategory: String
    var strCategory: String
    
    init(strCategoryThumb: String, idCategory: String, strCategory: String) {
        self.strCategoryThumb = strCategoryThumb
        self.idCategory = idCategory
        self.strCategory = strCategory
    }
}

struct SetCategoryResponse: Decodable {
    var meals: [SetCategory]
}

struct SetCategory: Decodable {
    var strMeal: String
    var strMealThumb: String
    var idMeal: String
    
    init(strMeal: String, strMealThumb: String, idMeal: String) {
        self.strMeal = strMeal
        self.strMealThumb = strMealThumb
        self.idMeal = idMeal
    }
}

func setCategory(searchQuery: String) async -> [SetCategory] {
    
    let encodedQuery = searchQuery.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    
    let urlString = "https://www.themealdb.com/api/json/v1/1/filter.php?c=\(encodedQuery)"
    
    guard let connection = URL(string: urlString) else {
        print("Invalid URL")
        return []
    }
    
    do {
        let (data, _) = try await URLSession.shared.data(from: connection)
        let response = try JSONDecoder().decode(SetCategoryResponse.self, from: data)
        return response.meals
    }
    catch {
        print("Error fetching data: \(error)")
        return []
    }
}

func getCategories() async -> [Category] {
    
    let collectString = "https://www.themealdb.com/api/json/v1/1/categories.php"
    
    guard let connection = URL(string: collectString) else {
        print("Invalid URL")
        return []
    }
    do {
        let (data, _) = try await URLSession.shared.data(from: connection)
        let response = try JSONDecoder().decode(CategoryResponse.self, from: data)
        return response.categories
    } catch {
        print("Error fetching data: \(error)")
        return []
    }
}
