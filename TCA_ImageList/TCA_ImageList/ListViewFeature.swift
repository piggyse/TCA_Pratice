//
//  ImageListViewFeature.swift
//  TCA_ImageList
//
//  Created by 박진섭 on 12/23/23.
//

import ComposableArchitecture

@Reducer
struct ListViewFeature {

    struct State: Equatable {
        var imageMetaDataArray: IdentifiedArrayOf<ImageMetaData> = []
        var path = StackState<ListItemViewFeature.State>()
    }

    enum Action {
        case fetchImageMetaDataArray
        case fetchMoreImageMetaData(Int)
        case imageMetaDataResponse([ImageMetaData])
        case moreImageMetaDataResponse([ImageMetaData])
        case path(StackAction<ListItemViewFeature.State, ListItemViewFeature.Action>)

        enum Alert: Equatable {
            case confirmDeletion(id: ImageMetaData.ID)
        }
    }

    @Dependency(\.imageUseCase) private var imageUseCase

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .fetchImageMetaDataArray:
                return .run { send in
                    let imageMetaDataArray = await imageUseCase.requestImageMetaDataList(size: 5) ?? []
                    await send(.imageMetaDataResponse(imageMetaDataArray))
                }
            case .fetchMoreImageMetaData(let size):
                return .run { send in
                    let imageMetaDataArray = await imageUseCase.requestImageMetaDataList(size: size) ?? []
                    await send(.moreImageMetaDataResponse(imageMetaDataArray))
                }
            case .imageMetaDataResponse(let imageMetaData):
                state.imageMetaDataArray = .init(uniqueElements: imageMetaData)
                return .none
            case .moreImageMetaDataResponse(let imageMetaData):
                state.imageMetaDataArray.append(contentsOf: imageMetaData)
                return .none
            case let .path(.element(id: id, action: .delegate(.confirmDeletion))):
                guard let detailState = state.path[id: id] else { return .none }
                state.imageMetaDataArray.remove(id: detailState.imageMetaData.id)
                return .none
            case .path:
                return .none
            }
        }
        .forEach(\.path, action: \.path) {
            ListItemViewFeature()
        }
    }
}

// 매크로 reducer 채택안하면 subscript 에러남.
