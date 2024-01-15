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
        @PresentationState var destination: Destination.State?
        var imageMetaDataArray: IdentifiedArrayOf<ImageMetaData> = []
        var path = StackState<ListItemFeature.State>()
    }

    enum Action: Equatable {
        case fetchImageMetaDataArray
        case fetchMoreImageMetaData(Int)
        case imageMetaDataResponse([ImageMetaData])
        case moreImageMetaDataResponse([ImageMetaData])
        case destination(PresentationAction<Destination.Action>)
    }

    @Reducer
    struct Destination {
        enum State: Equatable {
            case detail(ListItemFeature.State)
        }

        enum Action: Equatable {
            case detail(ListItemFeature.Action)
        }

        var body: some ReducerOf<Self> {
            Scope(state: \.detail, action: \.detail) {
                ListItemFeature()
            }
        }
    }

    @Dependency(\.imageUseCase) private var imageUseCase

    var body: some ReducerOf<Self> {
        Reduce { state, action in
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
                state.imageMetaDataArray = .init(uniqueElements: imageMetaData)
                return .none
            case .moreImageMetaDataResponse(let imageMetaData):
                state.imageMetaDataArray.append(contentsOf: imageMetaData)
                return .none
            case .destination(_):
//                state.destination = .detail(.init(author: detailItem))
                return .none
            }
        }
    }
}
