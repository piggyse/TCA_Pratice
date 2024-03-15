//
//  ImageInfo.swift
//  TCA_ImageList
//
//  Created by Gucci on 12/28/23.
//

import Foundation

struct ImageInfo: Decodable, Equatable, Identifiable {
    let id: String
    let height, width: Int
    let author: String
    let url, downloadURL: String

    enum CodingKeys: String, CodingKey {
        case id, author
        case height, width
        case url
        case downloadURL = "download_url"
    }
}
