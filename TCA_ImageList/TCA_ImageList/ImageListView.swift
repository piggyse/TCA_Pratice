//
//  ImageListViews.swift
//  TCA_ImageList
//
//  Created by 박진섭 on 12/23/23.
//

import SwiftUI
import ComposableArchitecture
import SDWebImageSwiftUI

struct ImageListView: View {
    private let store: StoreOf<ImageListViewFeature>
    @ObservedObject var viewStore: ViewStoreOf<ImageListViewFeature>

    init(store: StoreOf<ImageListViewFeature>) {
        self.store = store
        self.viewStore = .init(store, observe: { $0 })
    }

    var body: some View {
        LazyVStack {
            ForEach(viewStore.imageMetaDataArray) { imageMetaData in
                WebImage(url: .init(string: imageMetaData.download_url))
                    .placeholder(content: {
                        ProgressView()
                            .frame(width: 300, height: 300)
                    })
                    .resizable()
                    .frame(width: 300, height: 300)
            }
        }
        .task {
            viewStore.send(.fetchImageMetaDataArray)
        }
    }
}
