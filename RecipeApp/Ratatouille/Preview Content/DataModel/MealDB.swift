//
//  MealDB.swift
//  Ratatouille
//

import Foundation
import SwiftData

@Model final class MealDB {
  @Attribute(.unique) let id: UUID    // Oppretter egen primærnøkkel
  var oldID: String                   // ID fra TheMealDB
  var title: String
  var instructions: String
  var ingredients: String
  var area: AreaDB?
  var category: CategoryDB?
  var thumb: String
  var youtube: String
  var favorite: Bool
  var trash: Bool
  let create: Date
  var update: Date
  
  init() {
    id = UUID()
    oldID = ""
    title = ""
    instructions = ""
    ingredients = ""
    thumb = ""
    youtube = ""
    favorite = false
    trash = false
    create = Date.now
    update = Date.now

  }
}
