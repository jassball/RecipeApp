import SwiftData
import SwiftUI

struct CategoryArchive: View {
    @Environment(\.modelContext) private var context
    
    @Query(
        filter: #Predicate<CategoryDB> { $0.trash == true },
        sort: \CategoryDB.update,
        order: .reverse,
        animation: .default
    ) private var category: [CategoryDB]
    
    var body: some View {
        if category.isEmpty {
            Label("Ingen arkiverte kategorier", systemImage: "rectangle.on.rectangle.slash.fill")
        } else {
            Label("Arkiverte kategorier", systemImage: "rectangle.on.rectangle.fill")

            List(category) { category in
                HStack(alignment: .center) {
                    VStack(alignment: .leading) {
                        Text(category.title)
                            .fontWeight(.bold)
                        
                        Text("Arkivert: \(category.update.formatted(date: .abbreviated, time: .standard))")
                    }
                }
                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                    Button(role: .destructive) {
                        context.delete(category)
                    } label: {
                        Image(systemName: "trash.fill")
                    }
                    
                    Button(role: .cancel) {
                        category.update = Date.now
                        category.trash = false
                    } label: {
                        Image(systemName: "tray.and.arrow.up.fill")
                    }
                }
            }
        }
    }
}

#Preview {
    CategoryArchive().modelContainer(for: CategoryDB.self)
}

