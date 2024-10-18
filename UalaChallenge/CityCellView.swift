//
//  CityCellView.swift
//  UalaChallenge
//
//  Created by Leandro Berli on 18/10/2024.
//

import SwiftUI

struct CityCellView: View {
    var city: City
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(city.name + ", " + city.country)
                Text("\(city.coord.lat)" + ", " + "\(city.coord.lon)")
            }
            Button(action: {}, label: { Image(systemName: "heart") })
                .buttonStyle(.plain)
        }
    }
}
