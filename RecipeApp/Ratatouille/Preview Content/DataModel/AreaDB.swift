//
//  AreaDB.swift
//  Ratatouille
//

import Foundation
import SwiftData

@Model final class AreaDB {
  @Attribute(.unique) let id: UUID
    var oldID: String
  var title: String
  var countrycode: String
  var favorite: Bool
  var trash: Bool
  let create: Date
  var update: Date
  
  @Relationship(deleteRule: .noAction, inverse: \MealDB.area)
  var meals: [MealDB]?                
  init() {
    oldID = ""
    id = UUID()
    title = ""
    countrycode = ""
    favorite = false
    trash = false
    create = Date.now
    update = Date.now
  }
}
