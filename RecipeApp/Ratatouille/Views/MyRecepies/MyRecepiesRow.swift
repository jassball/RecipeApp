//
//  IngredientRow.swift
//  Ratatouille
//

import Foundation
import SwiftUI

struct MyRecepiesRow: View {
    var meal: MealDB
    
    var body: some View {
        ingredientRowContent
            .swipeActions(edge: .leading, allowsFullSwipe: true) {
                Button {
                    meal.favorite.toggle()
                } label: {
                    Image(systemName: "star.fill")
                }
                .tint(.yellow)
            }
            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                Button(role: .destructive) {
                    meal.trash = true
                } label: {
                    Image(systemName: "archivebox")
                }
            }
    }
  
    var ingredientRowContent: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                Text(meal.title)
                    .fontWeight(.semibold)
            }
            
            if meal.favorite {
                Spacer()
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                    .font(.title2)
            }
        }
    }
}

