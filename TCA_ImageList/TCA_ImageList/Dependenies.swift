//
//  Dependeny.swift
//  TCA_ImageList
//
//  Created by 박진섭 on 1/11/24.
//

import Foundation
import ComposableArchitecture

struct ImageUseCase {
    func requestImageMetaDataList(size: Int) async -> [ImageMetaData]? {
        guard let url = URL(string: "https://picsum.photos/v2/list?page=2&limit=\(size)"),
              let response = try? await URLSession.shared.data(for: .init(url: url)),
              let data = try? JSONDecoder().decode([ImageMetaData].self, from: response.0) else { return nil }
        return data
    }

    func requestImageData(_ imageURLString: String) async -> Data? {
        guard let url = URL(string: imageURLString),
              let response = try? await URLSession.shared.data(for: .init(url: url)) else { return nil }
        return response.0
    }
}

extension ImageUseCase: DependencyKey {
    static let liveValue = Self.init()
    static let mockValue = Self.init()
}

extension DependencyValues {
  var imageUseCase: ImageUseCase {
    get { self[ImageUseCase.self] }
    set { self[ImageUseCase.self] = newValue }
  }
}
