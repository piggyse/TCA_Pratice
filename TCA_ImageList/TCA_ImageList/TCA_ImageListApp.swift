//
//  TCA_ImageListApp.swift
//  TCA_ImageList
//
//  Created by 박진섭 on 12/23/23.
//

import SwiftUI
import ComposableArchitecture

@main
struct TCA_ImageListApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                MainView(store: .init(initialState: MainViewFeature.State(), reducer: { MainViewFeature()._printChanges() }))
                    .navigationTitle("이미지 리스트")
            }
        }
    }
}
