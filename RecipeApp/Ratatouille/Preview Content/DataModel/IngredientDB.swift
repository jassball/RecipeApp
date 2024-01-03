//
//  IngredientDB.swift
//  Ratatouille
//

import Foundation
import SwiftData

@Model final class IngredientDB {
  @Attribute(.unique) let id: UUID
  var oldID: String                  
  var title: String
  var descriptions: String
  var type: String
  var favorite: Bool
  var trash: Bool
  let create: Date
  var update: Date
  
  init() {
    id = UUID()
    oldID = ""
    title = ""
    descriptions = ""
    type = ""
    favorite = false
    trash = false
    create = Date.now
    update = Date.now
  }
}



