//
//  ImageInfo.swift
//  TCA_ImageList
//
//  Created by Gucci on 12/28/23.
//

import Foundation

struct ImageInfo: Decodable, Identifiable {
    let id: String
    let height, width: Int
    let author: String
    let urlWebPath, imageUrl: String

    enum CodingKeys: String, CodingKey {
        case id, author
        case height, width
        case urlWebPath = "url"
        case imageUrl = "download_url"
    }
}
