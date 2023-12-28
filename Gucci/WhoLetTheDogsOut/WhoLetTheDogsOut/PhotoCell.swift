//
//  PhotoCell.swift
//  WhoLetTheDogsOut
//
//  Created by Gucci on 12/28/23.
//

import SwiftUI

struct PhotoCell: View {
    let remoteImagePath: String
    private var url: URL? {
        URL(string: remoteImagePath)
    }
    
    var body: some View {
        AsyncImage(url: url) { asyncImagePhase in
            switch asyncImagePhase {
            case .empty:
                progressViewWhenEmpty
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
            case .failure(_):
                failureView
            @unknown default:
                failureView
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
            .overlay {
                Text("Something went wrong")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
            }
    }
}

#Preview {
    PhotoCell(remoteImagePath: "https://picsum.photos/seed/picsum/200/300")
}
