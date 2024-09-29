//
//  ExchangeRateListCoordinator.swift
//  CleanArchWithUIKitDemo
//
//  Created by Jill Chang on 2024/8/28.
//

import UIKit

public final class ExchangeRateListCoordinator: Coordinator {
    public struct Params {
        let view: PresentationView
        public init(view: PresentationView) {
            self.view = view
        }
    }

    public var navigationController: UINavigationController
    public var childCoordinators: [Coordinator] = []
    private let dependencies: ExchangeRateListCoordinatorDependencies
    private let param: Params

    public init(navigationController: UINavigationController, dependencies: ExchangeRateListCoordinatorDependencies, param: Params) {
        self.navigationController = navigationController
        self.dependencies = dependencies
        self.param = param
    }

    public func start() {
        let view = switch self.param.view {
        case .UIKit:
            makeExchangeRateListViewController()
        case .SwiftUI:
            makeExchangeRateListView()
        }
        self.navigationController.pushViewController(view, animated: false)
    }
}

extension ExchangeRateListCoordinator: ExchangeRateListViewModelDelegate {
    public func goToDetail(rate: ExchangeRateEntity.RateEntity) {
        let diContainer = self.dependencies.makeExchangeRateDetailDIContainer()
        let coordinator = diContainer.makeExchangeRateDetailCoordinator(navigationController: self.navigationController, param: ExchangeRateDetailCoordinator.Params(rateEntity: rate, view: self.param.view))
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
