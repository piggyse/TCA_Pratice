//
//  LoadingViewModifier.swift
//  TCA_ImageList
//
//  Created by 박진섭 on 12/23/23.
//

import SwiftUI
import ComposableArchitecture

struct LoadingViewModifier: ViewModifier {
    private var isLoading: Bool = true

    init(isLoading: Bool) {
        self.isLoading = isLoading
    }

    func body(content: Content) -> some View {
        content
            .overlay {
                if isLoading {
                    Text("이미지 불러오는 중...")
                }
            }
    }
}


extension View {
    func loadingView(_ isLoading: Bool) -> some View {
        self.modifier(LoadingViewModifier(isLoading: isLoading))
    }
}
