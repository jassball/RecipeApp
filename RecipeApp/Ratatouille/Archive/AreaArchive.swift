import SwiftData
import SwiftUI

struct AreaArchive: View {
    @Environment(\.modelContext) private var context
    
    @Query(
        filter: #Predicate<AreaDB> { $0.trash == true },
        sort: \AreaDB.update,
        order: .reverse,
        animation: .default
    ) private var area: [AreaDB]
    
    var body: some View {
        if area.isEmpty {
            Label("Ingen arkiverte områder", systemImage: "flag.slash.fill")
        } else {
            Label("Arkiverte områder", systemImage: "flag.fill")

            List(area) { area in
                HStack(alignment: .center) {
                    VStack(alignment: .leading) {
                        Text(area.title)
                            .fontWeight(.bold)
                            .padding()
                        
                        Text("Arkivert: \(area.update.formatted(date: .abbreviated, time: .standard))")
                    }
                }
                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                    Button(role: .destructive) {
                        context.delete(area)
                    } label: {
                        Image(systemName: "trash.fill")
                    }
                    
                    Button(role: .cancel) {
                        area.update = Date.now
                        area.trash = false
                    } label: {
                        Image(systemName: "tray.and.arrow.up.fill")
                    }
                }
            }
        }
    }
}

#Preview {
    AreaArchive().modelContainer(for: AreaDB.self)
}

