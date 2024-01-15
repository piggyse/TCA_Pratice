//
//  ListItemFeature.swift
//  TCA_ImageList
//
//  Created by 박진섭 on 1/13/24.
//

import Foundation
import ComposableArchitecture

struct ListItemFeature: Reducer {

    struct State: Equatable {
        var author: String
    }

    enum Action: Equatable {
        case deleteItem
    }

    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .deleteItem:
            return .none
        }
    }
}
