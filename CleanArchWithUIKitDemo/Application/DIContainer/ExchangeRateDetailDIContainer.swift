//
//  ExchangeRateDetailDIContainer.swift
//  CleanArchWithUIKitDemo
//
//  Created by Jill Chang on 2024/8/31.
//

import UIKit

public final class ExchangeRateDetailDIContainer {
    public init() {}

    public func makeExchangeRateDetailCoordinator(navigationController: UINavigationController, param: ExchangeRateDetailCoordinator.Params) -> ExchangeRateDetailCoordinator {
        ExchangeRateDetailCoordinator(navigationController: navigationController, dependencies: self, param: param)
    }
}

public protocol ExchangeRateDetailCoordinatorDependencies: AnyObject {
    func makeExchangeRateDetailViewController(param: ExchangeRateDetailCoordinator.Params) -> UIViewController
}

extension ExchangeRateDetailDIContainer: ExchangeRateDetailCoordinatorDependencies {
    public func makeExchangeRateDetailViewController(param: ExchangeRateDetailCoordinator.Params) -> UIViewController {
        // VM
        let viewModel = ExchangeRateDetailViewModel(param: param)
        // VC
        return ExchangeRateDetailViewController(viewModel: viewModel)
    }
}
