//
//  ListItemView.swift
//  TCA_ImageList
//
//  Created by 박진섭 on 1/14/24.
//

import SwiftUI
import ComposableArchitecture
import SDWebImageSwiftUI

struct ListItemView: View {
    private let store: StoreOf<ListItemViewFeature>
    @ObservedObject var viewStore: ViewStoreOf<ListItemViewFeature>

    init(store: StoreOf<ListItemViewFeature>) {
        self.store = store
        self.viewStore = .init(store, observe: { $0 } )
    }

    var body: some View {
        VStack(spacing: 8) {
            WebImage(url: .init(string: viewStore.imageMetaData.download_url))
                .placeholder(content: {
                    ProgressView()
                        .frame(width: 300, height: 300)
                })
                .resizable()
                .scaledToFill()
                .frame(width: 300, height: 300)

            HStack {
                Text("작가: ")
                Text(viewStore.imageMetaData.author)
            }

            Button {
                // 삭제 action
            } label: {
                HStack {
                    Text("삭제")
                    Image(systemName: "trash")
                }
                .foregroundColor(.red)
            }
            Spacer()
        }
        .padding()
    }
}

