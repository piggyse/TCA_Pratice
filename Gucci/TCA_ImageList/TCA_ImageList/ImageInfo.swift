//
//  ImageInfo.swift
//  TCA_ImageList
//
//  Created by Gucci on 12/28/23.
//

import Foundation

struct Urls: Codable {
    let raw, full, thumb, smallS3: String
    let regular, small: String

    enum CodingKeys: String, CodingKey {
        case raw, full, thumb
        case smallS3 = "small_s3"
        case regular, small
    }
}

struct ImageInfo: Codable, Identifiable {
    let id: String
    let height, width: Int
    let urls: Urls

    enum CodingKeys: String, CodingKey {
        case id
        case height, width, urls
    }
}
