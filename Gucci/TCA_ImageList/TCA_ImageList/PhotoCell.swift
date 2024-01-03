//
//  PhotoCell.swift
//  TCA_ImageList
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
    PhotoCell(remoteImagePath: "https://images.unsplash.com/photo-1682685796186-1bb4a5655653?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3wzOTQ1MDB8MXwxfGFsbHwxfHx8fHx8Mnx8MTcwNDI4Nzc4NXw&ixlib=rb-4.0.3&q=80&w=400")
}
