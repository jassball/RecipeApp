
//
//  MealDB.swift
//  Ratatouille
import Foundation
import SwiftData


struct AreaResponse: Decodable {
    var meals: [Area]
}

struct Area: Decodable {
    var strMeal: String
    var strMealThumb: String
    var idMeal: String
    
    init(idMeal: String, strMeal: String, strCategory: String, strArea: String, strMealThumb: String) {
        self.idMeal = idMeal
        self.strMeal = strMeal
        self.strMealThumb = strMealThumb
    }
}

struct GetAllAreasResponse: Decodable {
    var meals: [AllAreas]
}

struct AllAreas: Decodable, Hashable {
    var strArea: String
    
}



func getArea(searchQuery: String) async -> [Area] {
    
    let encodedQuery = searchQuery.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    
    let urlString = "https://www.themealdb.com/api/json/v1/1/filter.php?a=\(encodedQuery)"
    
    guard let connection = URL(string: urlString) else {
        print("Invalid URL")
        return []
    }
    
    do {
        let (data, _) = try await URLSession.shared.data(from: connection)
        let response = try JSONDecoder().decode(AreaResponse.self, from: data)
        return response.meals
    }
    catch {
        print("Error fetching data: \(error)")
        return []
    }
}


func getAllAreas() async -> [AllAreas] {
    
    let collectAllUrlString = "https://www.themealdb.com/api/json/v1/1/list.php?a=list"
    
    guard let connection = URL(string: collectAllUrlString) else {
        print("Invalid URL")
        return []
    }
    do {
        let (data, _) = try await URLSession.shared.data(from: connection)
        let response = try JSONDecoder().decode(GetAllAreasResponse.self, from: data)
        return response.meals
    } catch  {
        print("Error fetching data: \(error)")
        return []
    }
}


