//
//  CustomSplitView.swift
//  UalaChallenge
//
//  Created by Leandro Berli on 18/10/2024.
//

import SwiftUI

struct CustomSplitView<LandscapeContent: View, PortraitContent: View>: View {
    @State private var orientation = UIDeviceOrientation.unknown
    let landscapeView: LandscapeContent
    let portraitView: PortraitContent
    
    public init(@ViewBuilder landscapeView: () -> LandscapeContent, @ViewBuilder portrait: () -> PortraitContent) {
        self.landscapeView = landscapeView()
        self.portraitView = portrait()
    }
    
    var body: some View {
        if orientation.isLandscape {
            HStack {
                landscapeView
            }
            .onRotate { orientation in
                self.orientation = orientation
            }
            .onAppear {
                print("OnAppear: landscape CustomSplitView")
            }
        } else {
            VStack {
                portraitView
            }
            .onRotate { orientation in
                self.orientation = orientation
            }
            .onAppear {
                print("OnAppear: portrait CustomSplitView")
            }
        }
    }
}
