//
//  TCA_ImageListApp.swift
//  TCA_ImageList
//
//  Created by 박진섭 on 12/23/23.
//

import SwiftUI

@main
struct TCA_ImageListApp: App {
    var body: some Scene {
        WindowGroup {
            MainView(store: .init(initialState: MainViewFeature.State(), reducer: { MainViewFeature()._printChanges() }))
        }
    }
}
