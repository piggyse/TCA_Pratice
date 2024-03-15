//
//  ContentView.swift
//  TCA_ImageList
//
//  Created by Gucci on 12/18/23.
//

import SwiftUI
import ComposableArchitecture

struct ContentView: View {
    var body: some View {
        VStack {
            ImageListView(store: Store(initialState: ImageListFeature.State()) {
                ImageListFeature()
                    .dependency(\.picsumService, ImageService.liveValue)
            })
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
