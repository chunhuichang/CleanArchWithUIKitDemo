//
//  ExchangeRateDetailCoordinator.swift
//  CleanArchWithUIKitDemo
//
//  Created by Jill Chang on 2024/8/31.
//

import UIKit

public protocol ExchangeRateDetailCoordinatorDelegate: AnyObject {
    func dismiss(_ coordinator: Coordinator)
}

public final class ExchangeRateDetailCoordinator: Coordinator {
    public struct Params {
        let rateEntity: ExchangeRateEntity.RateEntity
        public init(rateEntity: ExchangeRateEntity.RateEntity) {
            self.rateEntity = rateEntity
        }
    }

    public var navigationController: UINavigationController
    public var childCoordinators: [Coordinator] = []
    private let dependencies: ExchangeRateDetailCoordinatorDependencies
    private let param: Params
    public weak var delegate: ExchangeRateDetailCoordinatorDelegate?

    public init(navigationController: UINavigationController, dependencies: ExchangeRateDetailCoordinatorDependencies, param: Params) {
        self.navigationController = navigationController
        self.dependencies = dependencies
        self.param = param
    }

    public func start() {
        guard let vc = dependencies.makeExchangeRateDetailViewController(param: param) as? ExchangeRateDetailViewController else {
            fatalError("Casting to ViewController fail")
        }
        vc.viewModel.delegate = self
        navigationController.pushViewController(vc, animated: false)
    }
}

extension ExchangeRateDetailCoordinator: ExchangeRateDetailViewModelDelegate {
    public func dismiss() {
        delegate?.dismiss(self)
    }
}
