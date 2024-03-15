//
//  PhotoCellFeature.swift
//  TCA_ImageList
//
//  Created by Gucci on 1/10/24.
//

import ComposableArchitecture

//@Reducer
//struct PhotoCellFeature {
//    struct State: Equatable {
//        var isLoading = false
//        var imageURL = ""
//    }
//    
//    enum Action {
//        case loadImageOccured
//        case imageResponse(String)
//    }
//    
//    @Dependency(\.picsumService) var picsumService
//    
//    var body: some ReducerOf<Self> {
//        Reduce { state, action in
//            switch action {
//            case .loadImageOccured:
//                state.isLoading = true
//                state.imageURL = ""
//                return .run { send in
//                    try await send(.imageResponse(picsumService.fetchRandomImage().imageUrl))
//                }
//            case .imageResponse(let imageUrl):
//                state.imageURL = imageUrl
//                state.isLoading = false
//                return .none
//            }
//        }
//    }
//}
