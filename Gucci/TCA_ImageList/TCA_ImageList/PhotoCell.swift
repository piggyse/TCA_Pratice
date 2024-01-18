//
//  PhotoCell.swift
//  TCA_ImageList
//
//  Created by Gucci on 12/28/23.
//

import SwiftUI
import ComposableArchitecture

struct PhotoCell: View {
    let store: StoreOf<PhotoCellFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            AsyncImage(url: URL(string: viewStore.imageURL)) { asyncImagePhase in
                switch asyncImagePhase {
                case .empty:
                    progressViewWhenEmpty
                case .success(let image):
                    image
                        .resizable()
                        .edgesIgnoringSafeArea(.all)
                        .aspectRatio(contentMode: .fill)
                        .clipped()
                case .failure(_):
                    failureView
                @unknown default:
                    failureView
                }
            }
            
        }
    }
}

private extension PhotoCell {
    @ViewBuilder
    var progressViewWhenEmpty: some View {
        Color(.white)
            .overlay {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .orange))
                    .scaleEffect(3)
            }
    }
    
    @ViewBuilder
    var failureView: some View {
        Color(.black)
            .frame(width: 200, height: 300)
            .overlay {
                Text("Something went wrong")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
            }
    }
}

#Preview {
    PhotoCell(store: Store(initialState: PhotoCellFeature.State()) {
        PhotoCellFeature()
    })
}
