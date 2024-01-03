//
//

import SwiftUI

struct MainView: View {
    @AppStorage("isDarkMode") private var darkMode = false

    var body: some View {
        TabView {
            MyRecepiesView().tabItem {
                Label("Mine oppskrifter", systemImage: "fork.knife.circle.fill")
            }
            SearchView().tabItem {
                Label("Søkefelt", systemImage: "magnifyingglass.circle.fill")
            }
            SettingsView().tabItem {
                Label("Instillinger", systemImage: "gear.circle.fill")
            }
        }
        .environment(\.colorScheme, darkMode ? .dark : .light)

    }
}

#Preview {
    MainView().modelContainer(for: [MealDB.self, AreaDB.self, IngredientDB.self, CategoryDB.self])
}
