//
//  ImageService.swift
//  TCA_ImageList
//
//  Created by Gucci on 12/28/23.
//

import Foundation

protocol ImageFetchable { 
    func fetchImage() async -> ImageInfo?
    func fetchList() async -> [ImageInfo]
}

struct ImageService: ImageFetchable {
    func fetchImage() async -> ImageInfo? {
        return nil
    }
    
    func fetchList() async -> [ImageInfo] {
        return []
    }
}
