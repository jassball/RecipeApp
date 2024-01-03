import SwiftData
import SwiftUI

struct MyRecepiesArchive: View {
    @Environment(\.modelContext) private var context
    
    @Query(
        filter: #Predicate<MealDB> { $0.trash == true },
        sort: \MealDB.update,
        order: .reverse,
        animation: .default
    ) private var meal: [MealDB]
    
    var body: some View {
        if meal.isEmpty {
            Label("Ingen arkiverte måltider", systemImage: "square.slash.fill")
        } else {
            List(meal) { meal in
                VStack(alignment: .leading) {
                    Text(meal.title)
                        .fontWeight(.bold)
                    
                    Text("Arkivert: \(meal.update.formatted(date: .abbreviated, time: .standard))")
                }
                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                    Button(role: .destructive) {
                        context.delete(meal)
                    } label: {
                        Image(systemName: "trash.fill")
                    }
                    
                    Button(role: .cancel) {
                        meal.update = Date.now
                        meal.trash = false
                    } label: {
                        Image(systemName: "tray.and.arrow.up.fill")
                    }
                }
            }
        }
    }
}

#Preview {
    MyRecepiesArchive().modelContainer(for: MealDB.self)
}

