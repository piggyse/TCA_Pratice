//
//  MainView.swift
//  TCA_ImageList
//
//  Created by 박진섭 on 12/23/23.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        ScrollView {
            ImageListView(store: .init(initialState: ImageListViewFeature.State(), reducer: { ImageListViewFeature() }))
        }
    }
}

