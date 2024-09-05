//
//  MockNavigationController.swift
//  CleanArchWithUIKitDemoTests
//
//  Created by Jill Chang on 2024/9/1.
//

import UIKit

public final class MockNavigationController: UINavigationController {
    var pushedViewControllers: [UIViewController] = []
    var poppedViewControllers: [UIViewController] = []

    override public func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushedViewControllers.append(viewController)
        super.pushViewController(viewController, animated: animated)
    }

    override public func popViewController(animated: Bool) -> UIViewController? {
        if let viewController = super.popViewController(animated: animated) {
            poppedViewControllers.append(viewController)
            return viewController
        }
        return nil
    }

    override public func popToRootViewController(animated: Bool) -> [UIViewController]? {
        let viewControllers = super.popToRootViewController(animated: animated)
        if let viewControllers {
            poppedViewControllers.append(contentsOf: viewControllers)
        }
        return viewControllers
    }

    override public func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        let viewControllers = super.popToViewController(viewController, animated: animated)
        if let viewControllers {
            poppedViewControllers.append(contentsOf: viewControllers)
        }
        return viewControllers
    }
}
