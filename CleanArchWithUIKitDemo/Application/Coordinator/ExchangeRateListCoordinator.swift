//
//  ExchangeRateListCoordinator.swift
//  CleanArchWithUIKitDemo
//
//  Created by Jill Chang on 2024/8/28.
//

import UIKit

public final class ExchangeRateListCoordinator: Coordinator {
    public var navigationController: UINavigationController
    public var childCoordinators: [Coordinator] = []
    private let dependencies: ExchangeRateListCoordinatorDependencies

    public init(navigationController: UINavigationController, dependencies: ExchangeRateListCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }

    public func start() {
        guard let vc = dependencies.makeExchangeRateListViewController() as? ExchangeRateListViewController else {
            fatalError("Casting to ViewController fail")
        }
        self.navigationController.pushViewController(vc, animated: false)
    }
}
