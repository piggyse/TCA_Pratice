//
//  PicsumResponse.swift
//  TCA_ImageList
//
//  Created by Gucci on 12/28/23.
//

import Foundation

// MARK: - PicsumResponseElement
struct ImageInfo: Codable, Hashable, Identifiable {
    let id, author: String
    let width, height: Int
    let url, downloadURL: String

    enum CodingKeys: String, CodingKey {
        case id, author, width, height, url
        case downloadURL = "download_url"
    }
}

struct PicsumResponse {
    let images: [ImageInfo]
}
