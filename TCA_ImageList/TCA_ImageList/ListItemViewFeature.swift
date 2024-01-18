//
//  ListItemFeature.swift
//  TCA_ImageList
//
//  Created by 박진섭 on 1/13/24.
//

import Foundation
import ComposableArchitecture

struct ListItemViewFeature: Reducer {

    struct State: Equatable {
        var imageMetaData: ImageMetaData
    }

    enum Action: Equatable {
        case deleteItem
        case delegate(Delegate)

        @CasePathable
        enum Delegate {
          case deleteImage
        }
    }

    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .deleteItem:
            return .none
        case .delegate:
            return .none
        }
    }
}
