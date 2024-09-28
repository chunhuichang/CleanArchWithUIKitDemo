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
        self.navigationController.pushViewController(makeExchangeRateListViewController(), animated: false)
    }
}

extension ExchangeRateListCoordinator: ExchangeRateListViewModelDelegate {
    public func goToDetail(rate: ExchangeRateEntity.RateEntity) {
        let diContainer = self.dependencies.makeExchangeRateDetailDIContainer()
        let coordinator = diContainer.makeExchangeRateDetailCoordinator(navigationController: self.navigationController, param: ExchangeRateDetailCoordinator.Params(rateEntity: rate))
        coordinator.delegate = self
        add(child: coordinator)
        coordinator.start()
    }
}

extension ExchangeRateListCoordinator: ExchangeRateDetailCoordinatorDelegate {
    public func dismiss(_ coordinator: Coordinator) {
        remove(child: coordinator)
    }
}

private extension ExchangeRateListCoordinator {
    func makeExchangeRateListViewController() -> UIViewController {
        self.dependencies.makeExchangeRateListViewController(delegate: self)
    }

    func makeExchangeRateListView() -> UIViewController {
        self.dependencies.makeExchangeRateListView(delegate: self)
    }
}
