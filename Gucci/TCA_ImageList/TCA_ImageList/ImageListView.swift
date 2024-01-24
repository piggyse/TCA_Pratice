//
//  ImageListView.swift
//  TCA_ImageList
//
//  Created by Gucci on 12/28/23.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct ImageListFeature {
    struct State: Equatable {
        var repository: [ImageInfo]
        var isLoading = false
        
        static func == (lhs: ImageListFeature.State, rhs: ImageListFeature.State) -> Bool {
            lhs.repository == rhs.repository
        }
        
        init(repository: [ImageInfo] = []) {
            self.repository = repository
        }
    }
    
    enum Action {
        case addButtonTapped
        case deleteButtonTapped(IndexSet)
        case clearButtonTapped
        case imageInfoResponse(ImageInfo)
    }
    
    @Dependency(\.picsumService) var service
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .addButtonTapped:
                state.isLoading = true
                return .run { send in
                    try await send(.imageInfoResponse(service.fetchRandomImage()))
                }
            case .clearButtonTapped:
                state.repository.removeAll()
                return .none
            case .deleteButtonTapped(let indexSet):
                state.repository.remove(atOffsets: indexSet)
                return .none
            case .imageInfoResponse(let imageInfo):
                state.isLoading = false
                state.repository.append(imageInfo)
                return .none
            }
        }
    }
}

struct ImageListView: View {
    let store: StoreOf<ImageListFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            List {
                ForEach(viewStore.repository) { imageInfo in
                    PhotoCell(imageInfo: imageInfo)
                }
                .onDelete { indexSet in
                    viewStore.send(.deleteButtonTapped(indexSet))
                }
            }
            .listStyle(.plain)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        viewStore.send(.addButtonTapped)
                    } label: {
                        Image(systemName: "plus.circle")
                    }
                }
                ToolbarItem(placement: .secondaryAction) {
                    Button {
                        viewStore.send(.clearButtonTapped)
                    } label: {
                        Text("Clear List")
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        ImageListView(store: Store(initialState: ImageListFeature.State()) {
            ImageListFeature()
                .dependency(\.picsumService, ImageService.liveValue)
        })
    }
}
