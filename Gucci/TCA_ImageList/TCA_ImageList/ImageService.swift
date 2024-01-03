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
        guard let endUrl = URL(string: "https://api.unsplash.com/photos/random?count=1&client_id=pw9v2LZb37qkSEeX45NqeGenp2vKA6i65OwgxlQEryw") else { return nil }
        guard let (data, _) = try? await URLSession.shared.data(from: endUrl) else { return nil }
        
        if let imageInfomation = try? JSONDecoder().decode([ImageInfo].self, from: data).first {
            return imageInfomation
        } else {
            if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers),
               let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
                print(String(decoding: jsonData, as: UTF8.self))
            } else {
                print("json data malformed")
            }
            return nil
        }
    }
    
    func fetchList() async -> [ImageInfo] {
        guard let endUrl = URL(string: "https://api.unsplash.com/photos?client_id=pw9v2LZb37qkSEeX45NqeGenp2vKA6i65OwgxlQEryw") else { return [] }
        guard let (data, _) = try? await URLSession.shared.data(from: endUrl) else { return [] }
        
        if let imageInfomations = try? JSONDecoder().decode([ImageInfo].self, from: data) {
            return imageInfomations
        } else {
            if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers),
               let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
                print(String(decoding: jsonData, as: UTF8.self))
            } else {
                print("json data malformed")
            }
            return []
        }
    }
}
