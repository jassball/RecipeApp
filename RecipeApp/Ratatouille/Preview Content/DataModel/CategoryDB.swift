//
//  CategoryDB.swift
//  Ratatouille
//

import Foundation
import SwiftData

@Model final class CategoryDB {
  @Attribute(.unique) let id: UUID    // Oppretter egen primærnøkkel
  var oldID: String                   // ID fra TheMealDB
  var title: String
  var descriptions: String
  var thumb: String
  var favorite: Bool
  var trash: Bool
  let create: Date
  var update: Date
  
  @Relationship(deleteRule: .noAction, inverse: \MealDB.category)
  var meals: [MealDB]?                // Setter opp relasjon mellom CategoryDB og MealDB
                                      // En kategori kan være med i mange oppskrifter
  init() {
    id = UUID()
    oldID = ""
    title = ""
    descriptions = ""
    thumb = ""
    favorite = false
    trash = false
    create = Date.now
    update = Date.now
  }
}
