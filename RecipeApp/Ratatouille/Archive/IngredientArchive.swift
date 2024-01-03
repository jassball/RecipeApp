import SwiftData
import SwiftUI

struct IngredientArchive: View {
    @Environment(\.modelContext) private var context
    
    @Query(
        filter: #Predicate<IngredientDB> { $0.trash == true },
        sort: \IngredientDB.update,
        order: .reverse,
        animation: .default
    ) private var ingredient: [IngredientDB]
    
    var body: some View {
        if ingredient.isEmpty {
            Label("Ingen arkiverte ingredienser", systemImage: "key.slash.fill")
        } else {
            List(ingredient) { ingredient in
                VStack(alignment: .leading) {
                    Text(ingredient.title)
                        .fontWeight(.bold)
                    
                    Text("Arkivert: \(ingredient.update.formatted(date: .abbreviated, time: .standard))")
                }
                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                    Button(role: .destructive) {
                        context.delete(ingredient)
                    } label: {
                        Image(systemName: "trash.fill")
                    }
                    
                    Button(role: .cancel) {
                        ingredient.update = Date.now
                        ingredient.trash = false
                    } label: {
                        Image(systemName: "tray.and.arrow.up.fill")
                    }
                }
            }
        }
    }
}

#Preview {
    IngredientArchive().modelContainer(for: IngredientDB.self)
}

