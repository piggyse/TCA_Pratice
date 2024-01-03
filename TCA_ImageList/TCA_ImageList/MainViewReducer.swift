//
//  MainViewReducer.swift
//  TCA_ImageList
//
//  Created by 박진섭 on 1/3/24.
//

import ComposableArchitecture

struct MainViewReducer: Reducer {
    struct State: Equatable {
        var isLoading = true
        var imageListViewState = ListViewReducer.State()
    }

    enum Action: Equatable {
        case listViewDataIsLoaded(ListViewReducer.Action)
    }

    var body: some Reducer<State, Action> {
        // child reducer 정의
        Scope(state: \.imageListViewState, action: /Action.listViewDataIsLoaded) {
            ListViewReducer()
        }
        
        Reduce { state, action in
            switch action {
            case .listViewDataIsLoaded(.imageMetaDataResponse):
                state.isLoading = false
                print(state.isLoading)
                return .none
            default:
                return .none
            }
        }
    }
}
