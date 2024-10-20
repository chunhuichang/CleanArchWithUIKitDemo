//
//  LoadingOverlay.swift
//  CleanArchWithUIKitDemo
//
//  Created by Jill Chang on 2024/10/20.
//

import SwiftUI

struct LoadingOverlay: ViewModifier {
    let isLoadingRefresh: Bool
    let isLoadingProgress: Bool

    func body(content: Content) -> some View {
        ZStack {
            content
            
            if isLoadingRefresh || isLoadingProgress {
                Color.black.opacity(0.6)
                    .ignoresSafeArea()

                if isLoadingProgress {
                    ProgressView {
                        Text("Loading, please wait...")
                            .font(.system(size: 16.0, weight: .bold))
                            .foregroundStyle(.white)
                    }
                    .tint(.white)
                    .controlSize(.large)
                }
            }
        }
    }
}

extension View {
    func loadingOverlay(isLoadingRefresh: Bool, isLoadingProgress: Bool) -> some View {
        modifier(LoadingOverlay(isLoadingRefresh: isLoadingRefresh, isLoadingProgress: isLoadingProgress))
    }
}
