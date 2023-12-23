//
//  ImageMetaData.swift
//  TCA_ImageList
//
//  Created by 박진섭 on 12/23/23.
//

import Foundation

import Foundation

struct ImageMetaData: Codable, Equatable, Identifiable {
    let id: String
    let author: String
    let width: Int
    let height: Int
    let url: String
    let download_url: String
}
