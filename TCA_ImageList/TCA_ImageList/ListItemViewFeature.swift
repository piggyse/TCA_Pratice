//
//  ListItemFeature.swift
//  TCA_ImageList
//
//  Created by 박진섭 on 1/13/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct ListItemViewFeature {

    struct State: Equatable {
        @PresentationState var alert: AlertState<Action.Alert>?
        var imageMetaData: ImageMetaData
    }

    enum Action {
        case alert(PresentationAction<Alert>)
        case delegate(Delegate)
        case deleteButtonTapped
        enum Alert {
            case confirmDeletion
        }
        enum Delegate {
            case confirmDeletion
        }
    }

    @Dependency(\.dismiss) var dismiss

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .alert(.presented(.confirmDeletion)):
                return .run { send in
                    await send(.delegate(.confirmDeletion))
                    await self.dismiss()
                }
            case .alert:
                return .none
            case .delegate:
                return .none
            case .deleteButtonTapped:
                state.alert = .confirmDeletion
                return .none
            }
        }
        // 이거 빼먹으면 삭제 버튼 탭할때 delegate 실행됨 
        .ifLet(\.$alert, action: \.alert)
    }
}

extension AlertState where Action == ListItemViewFeature.Action.Alert {
    static let confirmDeletion = Self {
        TextState("정말로 삭제하시겠습니까?")
    } actions: {
        ButtonState(role: .destructive, action: .confirmDeletion) {
            TextState("삭제")
        }
    }
}
