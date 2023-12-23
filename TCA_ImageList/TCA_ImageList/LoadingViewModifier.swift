//
//  LoadingViewModifier.swift
//  TCA_ImageList
//
//  Created by 박진섭 on 12/23/23.
//

import SwiftUI

struct LoadingViewModifier: ViewModifier {
    var isLoading: Bool

    init(isLoading: Bool) {
        self.isLoading = isLoading
    }

    func body(content: Content) -> some View {
        ZStack {
            content
            if isLoading {
                ProgressView()
                    .progressViewStyle(.circular)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.white)
            }
        }
    }
}
