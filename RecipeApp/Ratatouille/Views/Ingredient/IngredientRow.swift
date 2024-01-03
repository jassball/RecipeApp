//
//  IngredientRow.swift
//  Ratatouille
//

import Foundation
import SwiftUI

struct IngredientRow: View {
    var ingredient: IngredientDB
    
    var body: some View {
        ingredientRowContent
            .swipeActions(edge: .leading, allowsFullSwipe: true) {
                Button {
                    ingredient.favorite.toggle()
                } label: {
                    Image(systemName: "star.fill")
                        .tint(.yellow)
                }
            }
            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                Button(role: .destructive) {
                    ingredient.trash = true
                } label: {
                    Image(systemName: "archivebox")
                }
            }
    }
    
    var ingredientRowContent: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                Text(ingredient.title)
                    .fontWeight(.semibold)
            }
            
            if ingredient.favorite {
                Spacer()
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                    .font(.title2)
            }
        }
    }
}

