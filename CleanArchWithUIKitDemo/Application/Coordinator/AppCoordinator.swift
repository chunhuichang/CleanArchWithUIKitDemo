//
//  AppCoordinator.swift
//  CleanArchWithUIKitDemo
//
//  Created by Jill Chang on 2024/8/23.
//

import UIKit

public final class AppCoordinator: Coordinator {
    public var navigationController: UINavigationController
    public var childCoordinators: [Coordinator] = []
    private let appDIContainer = AppDIContainer()

    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    public func start() {
        // TODO: Create list coordinator
    }
}
