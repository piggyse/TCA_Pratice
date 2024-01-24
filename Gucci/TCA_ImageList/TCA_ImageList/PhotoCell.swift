//
//  PhotoCell.swift
//  TCA_ImageList
//
//  Created by Gucci on 12/28/23.
//

import SwiftUI
import ComposableArchitecture

struct PhotoCell: View {
    let imageInfo: ImageInfo
    
    var body: some View {
        AsyncImage(url: URL(string: imageInfo.downloadURL)) { asyncImagePhase in
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
            .frame(width: 200, height: 300)
            .overlay {
                Text("Something went wrong")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
            }
    }
}

#Preview {
    PhotoCell(imageInfo: .init(id: "0", height: 200, width: 300, author: "Gucci", url: "", downloadURL: "https://fastly.picsum.photos/id/276/200/300.jpg?hmac=5VSJJxPMnu25ukKlrNc0y2KxLtG_jF7BfA13IlTm0uo"))
}
