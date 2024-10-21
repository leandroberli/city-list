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
    var didSelectAction: () -> Void
    
    var body: some View {
        Button(action: {
            didSelectAction()
        }, label: {
            HStack {
                VStack(alignment: .leading) {
                    Text(city.name + ", " + city.country).font(.system(size: 16, weight: .regular))
                    Text("\(city.coord.lat)" + ", " + "\(city.coord.lon)").font(.system(size: 12, weight: .light))
                }
                Spacer()
                Button(action: {
                    favoriteAction()
                }, label: {
                    city.favorite ?? false ? Image(systemName: "heart.fill").tint(.red) : Image(systemName: "heart").tint(.red)
                })
                .buttonStyle(.plain)
            }
        })
        .tint(.primary)
    }
}
