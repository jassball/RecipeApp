//
//  RatatouilleApp.swift
//  Ratatouille
//
//  Created by Jonas Stafset on 16/11/2023.
//

import SwiftUI
import SwiftData


@main
struct RatatouilleApp: App {
    @State var isSplash = true
    var body: some Scene {
        
        WindowGroup {
            
            if isSplash {
                SplashView(splash: $isSplash)
            } else {
                MainView().modelContainer(for: [MealDB.self, AreaDB.self, IngredientDB.self, CategoryDB.self])
            }
            
        }
    }
}

