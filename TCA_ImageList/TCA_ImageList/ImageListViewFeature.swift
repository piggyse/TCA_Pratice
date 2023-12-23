//
//  ImageListViewFeature.swift
//  TCA_ImageList
//
//  Created by 박진섭 on 12/23/23.
//

import Foundation
import ComposableArchitecture

struct ImageListViewFeature: Reducer {
    private let imageUseCase = ImageUseCase()

    struct State: Equatable {
        var imageMetaDataArray: [ImageMetaData] = []
        var isLoadingImageMetaDataArray: Bool = false
    }

    enum Action {
        case fetchImageMetaDataArray
        case fetchMoreImageMetaData(Int)
        case imageMetaDataResponse([ImageMetaData])
        case moreImageMetaDataResponse([ImageMetaData])
    }

    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .fetchImageMetaDataArray:
            state.isLoadingImageMetaDataArray = true
            return .run { send in
                let imageMetaDataArray = await imageUseCase.requestImageMetaDataList(size: 10) ?? []
                await send(.imageMetaDataResponse(imageMetaDataArray))
            }
        case .fetchMoreImageMetaData(let size):
            return .run { send in
                let imageMetaDataArray = await imageUseCase.requestImageMetaDataList(size: size) ?? []
                await send(.moreImageMetaDataResponse(imageMetaDataArray))
            }
        case .imageMetaDataResponse(let imageMetaData):
            state.imageMetaDataArray = imageMetaData
            state.isLoadingImageMetaDataArray = false
            return .none

        case .moreImageMetaDataResponse(let imageMetaData):
            state.imageMetaDataArray.append(contentsOf: imageMetaData)
            return .none
        }
    }
}
