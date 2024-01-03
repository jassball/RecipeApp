//
//  MealView.swift
//  Ratatouille
//

import SwiftData
import SwiftUI

struct MyRecepiesView: View {
    
    @Environment(\.modelContext) private var context
    @Query(
        filter: #Predicate<MealDB> { $0.trash == false },
        sort: \MealDB.title,
        order: .forward,
        animation: .default
    ) private var meals: [MealDB]
    @AppStorage("isDarkMode") private var darkMode = false

    
    var body: some View {
        theRecepies
    }
    
    var theRecepies: some View {
        NavigationStack {
            Text("Mine oppskrifter")
                .font(.title2)
                .foregroundColor(.white)
                .padding()
                .background(Color.black.opacity(0.5))
                .cornerRadius(10)
            
            Spacer(minLength: 100)
            
            if meals.isEmpty {
                ContentUnavailableView("Ingen oppskrifter lagret", systemImage: "square.stack.3d.up.slash")
            } else {
                Divider()
                List(meals, id: \.oldID) { meal in
                    NavigationLink(destination: RecipeDetailView(id: meal.oldID)) {
                        VStack(alignment: .trailing) {
                            ZStack(alignment: .bottomLeading) {
                                if let imageUrl = URL(string: meal.thumb) {
                                    AsyncImage(url: imageUrl) { image in
                                        image.resizable()
                                            .aspectRatio(contentMode: .fill)
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .frame(width: 300, height: 150)
                                    .cornerRadius(10)
                                    .clipped()
                                }
                                VStack(alignment: .leading) {
                                    Text(meal.title)
                                        .font(.headline)
                                    if meal.favorite {
                                        Image(systemName: "star.fill")
                                            .foregroundColor(.yellow)
                                            .font(.title2)
                                    }
                                }
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.black.opacity(0.5))
                                .cornerRadius(10)
                            }
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
                    }
                }
                .listStyle(.plain)
            }
        }
        .environment(\.colorScheme, darkMode ? .dark : .light)
    }
}

#Preview
{
    MyRecepiesView().modelContainer(for: MealDB.self)
}

