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
        List {
            ForEach(images) { imageInfo in
                let remotePath = imageInfo.urls.small
                PhotoCell(remoteImagePath: remotePath)
            }
            .onDelete(perform: delete)
        }
        .listStyle(.plain)
        .task(priority: .background) {
            self.images = await service.fetchList()
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    add()
                } label: {
                    Image(systemName: "plus.circle")
                }
            }
        }
        .navigationTitle("사진 수: \(images.count)")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func delete(at offsets: IndexSet) {
        images.remove(atOffsets: offsets)
    }
    
    private func add() {
        Task {
            guard let image = await service.fetchImage() else { return }
            self.images.append(image)
        }
    }
}

#Preview {
    NavigationStack {
        ImageListView()
    }
}
