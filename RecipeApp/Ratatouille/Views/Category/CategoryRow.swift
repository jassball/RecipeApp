//
//  Ratatouille
//

import SwiftUI

struct CategoryRow: View {
    var category: CategoryDB
    
    var body: some View {
        HStack(alignment: .center) {
            
            VStack(alignment: .leading) {
                Text(category.title)
                    .fontWeight(.semibold)
            }
            
            if category.favorite {
                Spacer()
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                    .font(.title2)
            }
        }
        .swipeActions(edge: .leading, allowsFullSwipe: true) {
            Button {
                category.favorite.toggle()
            } label: {
                Image(systemName: "star.fill")
            }
            .tint(.yellow)
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
            Button(role: .destructive) {
                category.trash = true
            } label: {
                Image(systemName: "archivebox")
            }
        }
    }
}

