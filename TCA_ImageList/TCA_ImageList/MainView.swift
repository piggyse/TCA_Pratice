//
//  MainView.swift
//  TCA_ImageList
//
//  Created by 박진섭 on 12/23/23.
//

import SwiftUI
import ComposableArchitecture

struct MainView: View {
    private let store: StoreOf<MainViewReducer>
    @ObservedObject var viewStore: ViewStoreOf<MainViewReducer>

    init(store: StoreOf<MainViewReducer>) {
        self.store = store
        self.viewStore = .init(store, observe: { $0 })
    }

    var body: some View {
        ScrollView {
            ImageListView(store: self.store.scope(state: \.imageListViewState,
                                                  action: MainViewReducer.Action.listViewDataIsLoaded))
        }
        .loadingView(viewStore.isLoading)
    }
}
