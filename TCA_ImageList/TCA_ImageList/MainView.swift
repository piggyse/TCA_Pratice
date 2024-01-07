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
    @State private var moreImageSizeText: String = ""

    init(store: StoreOf<MainViewReducer>) {
        self.store = store
        self.viewStore = .init(store, observe: { $0 })
    }

    var body: some View {
        VStack {
            HStack {
                TextField("숫자를 입력해주세요.", text: $moreImageSizeText)
                    .padding(6)
                    .overlay(content: {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.blue)
                    })
                    .padding(.trailing, 16)
                Button("확인") {
                    guard let imageSize = Int(moreImageSizeText) else { return }
                    store.send(.listViewAction(.fetchMoreImageMetaData(imageSize)))
                }
                .buttonStyle(.borderedProminent)
            }
            ScrollView {
                ImageListView(store: self.store.scope(state: \.imageListViewState,
                                                      action: MainViewReducer.Action.listViewAction))
            }
        }
        .padding()
        .loadingView(viewStore.isLoading)
    }
}


