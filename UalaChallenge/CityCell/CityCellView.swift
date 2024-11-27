//
//  CityCellView.swift
//  UalaChallenge
//
//  Created by Leandro Berli on 18/10/2024.
//

import SwiftUI

struct CityCellView: View {
    var model: CityCellModel
    var favoriteAction: () -> Void
    var didSelectAction: () -> Void
    
    var body: some View {
        Button(action: {
            didSelectAction()
        }, label: {
            HStack {
                VStack(alignment: .leading) {
                    Text(model.city.name + ", " + model.city.country).font(.system(size: 16, weight: .regular))
                    Text("\(model.city.coord.lat)" + ", " + "\(model.city.coord.lon)").font(.system(size: 12, weight: .light))
                }
                Spacer()
                Button(action: {
                    favoriteAction()
                }, label: {
                    model.isFavorite ?? false ? Image(systemName: "heart.fill").tint(.red) : Image(systemName: "heart").tint(.red)
                })
                .buttonStyle(.plain)
            }
        })
        .tint(.primary)
    }
}
