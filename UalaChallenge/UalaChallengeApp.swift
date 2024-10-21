//
//  UalaChallengeApp.swift
//  UalaChallenge
//
//  Created by Leandro Berli on 16/10/2024.
//

import SwiftUI

@main
struct UalaChallengeApp: App {
    var body: some Scene {
        WindowGroup {
            CityListView()
                .onAppear {
                    print("OnAppear: UalaChallengeApp")
                }
        }
    }
}
