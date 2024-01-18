//
//  ImageService.swift
//  TCA_ImageList
//
//  Created by Gucci on 12/28/23.
//

import ComposableArchitecture
import Foundation

enum ImageError: Error {
    case urlFail
    case decodingFail
    case networkConnectionFail
}

protocol ImageFetchable {
    var fetchRandomImage: () async throws -> ImageInfo { get }
}

struct ImageService {
    var fetchRandomImage: () async throws -> ImageInfo
}

extension ImageService: DependencyKey, ImageFetchable {
    static var liveValue = ImageService(fetchRandomImage: {
        guard let endUrl = URL(string: "https://picsum.photos/200/300") else { throw ImageError.urlFail }
        guard let (data, _) = try? await URLSession.shared.data(from: endUrl) else { throw ImageError.networkConnectionFail }
        
        if let imageInfomation = try? JSONDecoder().decode([ImageInfo].self, from: data).first {
            return imageInfomation
        } else {
            if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers),
               let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
                print(String(decoding: jsonData, as: UTF8.self))
            } else {
                print("json data malformed")
            }
            throw ImageError.decodingFail
        }
    })
}

extension DependencyValues {
    var picsumService: ImageService {
        get { self[ImageService.self] }
        set { self[ImageService.self] = newValue }
    }
}
