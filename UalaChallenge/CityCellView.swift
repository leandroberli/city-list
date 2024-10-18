//
//  CityCellView.swift
//  UalaChallenge
//
//  Created by Leandro Berli on 18/10/2024.
//

import SwiftUI

struct CityCellView: View {
    var city: City
    var favoriteAction: () -> Void
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(city.name + ", " + city.country)
                Text("\(city.coord.lat)" + ", " + "\(city.coord.lon)")
            }
            Button(action: {
                favoriteAction()
            }, label: {
                city.favorite ?? false ? Image(systemName: "heart.fill") : Image(systemName: "heart")
            })
            .buttonStyle(.plain)
        }
    }
}
