//
//  ImageListViewFeature.swift
//  TCA_ImageList
//
//  Created by 박진섭 on 12/23/23.
//

import ComposableArchitecture

struct ListViewFeature: Reducer {
    private let requestImageSize: Int

    init(requestImageSize: Int = 5) {
        self.requestImageSize = requestImageSize
    }

    struct State: Equatable {
//        @PresentationState var detailItem
        var imageMetaDataArray: [ImageMetaData] = []
    }

    enum Action: Equatable {
        case fetchImageMetaDataArray
        case fetchMoreImageMetaData(Int)
        case imageMetaDataResponse([ImageMetaData])
        case moreImageMetaDataResponse([ImageMetaData])
    }

    @Dependency(\.imageUseCase) private var imageUseCase

    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .fetchImageMetaDataArray:
            return .run { send in
                let imageMetaDataArray = await imageUseCase.requestImageMetaDataList(size: requestImageSize) ?? []
                await send(.imageMetaDataResponse(imageMetaDataArray))
            }
        case .fetchMoreImageMetaData(let size):
            return .run { send in
                let imageMetaDataArray = await imageUseCase.requestImageMetaDataList(size: size) ?? []
                await send(.moreImageMetaDataResponse(imageMetaDataArray))
            }
        case .imageMetaDataResponse(let imageMetaData):
            state.imageMetaDataArray = imageMetaData
            return .none
        case .moreImageMetaDataResponse(let imageMetaData):
            state.imageMetaDataArray.append(contentsOf: imageMetaData)
            return .none
        }
    }
}
