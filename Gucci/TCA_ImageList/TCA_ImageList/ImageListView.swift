//
//  ImageListView.swift
//  TCA_ImageList
//
//  Created by Gucci on 12/28/23.
//

import SwiftUI

struct ImageListView: View {
    @State private var images = [ImageInfo]()
    private let service = ImageService()
    
    var body: some View {
        List(images) { imageInfo in
            let urlString = imageInfo.url
            PhotoCell(remoteImagePath: urlString)
        }
        .task(priority: .background) {
            self.images = await service.fetchList()
        }
    }
}

#Preview {
    ImageListView()
}
