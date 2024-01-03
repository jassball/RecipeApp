//
//  DetailDB.swift
//  Ratatouille

import Foundation

func fetchRecipeDetails(mealId: String) async -> Meal? {
    let urlString = "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(mealId)"

    guard let url = URL(string: urlString) else {
        print("Invalid URL")
        return nil
    }

    do {
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(Meals.self, from: data)
        return response.meals.first
    } catch {
        print("Error fetching recipe details: \(error)")
        return nil
    }
}
