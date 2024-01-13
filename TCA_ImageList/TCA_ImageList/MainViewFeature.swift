//
//  MainViewReducer.swift
//  TCA_ImageList
//
//  Created by 박진섭 on 1/3/24.
//

import ComposableArchitecture

struct MainViewFeature: Reducer {
    struct State: Equatable {
        var isLoading = true
        var imageListViewState = ListViewFeature.State()
    }

    enum Action: Equatable {
        case listViewAction(ListViewFeature.Action)
    }

    var body: some Reducer<State, Action> {
        // child reducer 정의
        Scope(state: \.imageListViewState, action:  /Action.listViewAction) {
            ListViewFeature()
        }
        
        Reduce { state, action in
            switch action {
            case .listViewAction(.imageMetaDataResponse):
                state.isLoading = false
                return .none
            default:
                return .none
            }
        }
    }
}
