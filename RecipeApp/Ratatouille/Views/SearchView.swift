//
//  SettingsView.swift
//  Ratatouille
//

import SwiftUI

struct SearchView: View {
    @State private var meals: [Meal] = []
    @State private var selectedTab: Int = 0
    @AppStorage("isDarkMode") private var darkMode = false


       var body: some View {
           VStack {
               // Custom Tab Bar
               HStack {
                   TabBarButton(title: "Ingrediens", systemImage: "carrot.fill", selectedTab: $selectedTab, tag: 0)
                   TabBarButton(title: "Land", systemImage: "flag.circle.fill", selectedTab: $selectedTab, tag: 1)
                   TabBarButton(title: "Kategori", systemImage: "list.clipboard.fill", selectedTab: $selectedTab, tag: 2)
                   TabBarButton(title: "Søk", systemImage: "magnifyingglass.circle.fill", selectedTab: $selectedTab, tag: 3)
               }
               
               .padding()
               .background(Color.gray.opacity(0.1))
               
               // Tab Content
               TabView(selection: $selectedTab) {
                   IngredientView()
                       .tag(0)
                   AreaView(meals: $meals)
                       .tag(1)
                   CategoryView(meals: $meals)
                       .tag(2)
                   SearchingView()
                       .tag(3)
               }
           }
           .environment(\.colorScheme, darkMode ? .dark : .light)

       }

   }

   struct TabBarButton: View {
       let title: String
       let systemImage: String
       @Binding var selectedTab: Int
       let tag: Int

       var body: some View {
           Button(action: {
               selectedTab = tag
           }) {
               VStack {
                   Image(systemName: systemImage)
                   Text(title)
               }
           }
           .foregroundColor(selectedTab == tag ? .blue : .gray)
           .frame(maxWidth: .infinity)

       }
   }



#Preview {
    SearchView()
}

