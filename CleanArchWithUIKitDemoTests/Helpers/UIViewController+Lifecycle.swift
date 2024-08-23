//
//  UIViewController+Lifecycle.swift
//  CleanArchWithUIKitDemoTests
//
//  Created by Jill Chang on 2024/8/23.
//

import UIKit

extension UIViewController {
    func triggerLifecycleIfNeeded() {
        guard !isViewLoaded else { return }

        // Ensure the view is loaded
        loadViewIfNeeded()
        beginAppearanceTransition(true, animated: false)
        endAppearanceTransition()
    }
}
