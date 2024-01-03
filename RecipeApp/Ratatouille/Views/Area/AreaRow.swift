//
//  AreaRow.swift
//  Ratatouille
//

import SwiftUI

struct AreaRow: View {
    var area: AreaDB
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                Text(area.title)
                    .fontWeight(.semibold)
                Text(area.countrycode)
            }
            
            if area.favorite {
                Spacer()
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                    .font(.title2)
            }
        }
        .swipeActions(edge: .leading, allowsFullSwipe: true) {
            Button {
                area.favorite.toggle()
            } label: {
                Image(systemName: "star.fill")
            }
            .tint(.yellow)
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
            Button(role: .destructive) {
                area.trash = true
            } label: {
                Image(systemName: "archivebox")
            }
        }
    }
}

