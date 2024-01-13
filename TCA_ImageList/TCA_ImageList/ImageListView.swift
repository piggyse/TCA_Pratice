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
    private let store: StoreOf<ListViewFeature>
    @ObservedObject var viewStore: ViewStoreOf<ListViewFeature>

    init(store: StoreOf<ListViewFeature>) {
        self.store = store
        self.viewStore = .init(store, observe: { ListViewFeature.State(imageMetaDataArray: $0.imageMetaDataArray)} )
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
                    .scaledToFill()
                    .frame(width: 300, height: 300)
                    .onTapGesture {
                        
                    }
            }
        }
        .task {
            viewStore.send(.fetchImageMetaDataArray)
        }
    }
}
