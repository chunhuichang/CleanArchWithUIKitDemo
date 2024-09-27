//
//  ExchangeRateDetailDIContainer.swift
//  CleanArchWithUIKitDemo
//
//  Created by Jill Chang on 2024/8/31.
//

import SwiftUI
import UIKit

public final class ExchangeRateDetailDIContainer {
    public init() {}

    public func makeExchangeRateDetailCoordinator(navigationController: UINavigationController, param: ExchangeRateDetailCoordinator.Params) -> ExchangeRateDetailCoordinator {
        ExchangeRateDetailCoordinator(navigationController: navigationController, dependencies: self, param: param)
    }
}

public protocol ExchangeRateDetailCoordinatorDependencies: AnyObject {
    func makeExchangeRateDetailViewController(param: ExchangeRateDetailCoordinator.Params) -> UIViewController
    func makeExchangeRateDetailView(param: ExchangeRateDetailCoordinator.Params) -> UIViewController
}

extension ExchangeRateDetailDIContainer: ExchangeRateDetailCoordinatorDependencies {
    public func makeExchangeRateDetailViewController(param: ExchangeRateDetailCoordinator.Params) -> UIViewController {
        // VM
        let viewModel = ExchangeRateDetailViewModel(param: param)
        // VC
        return ExchangeRateDetailViewController(viewModel: viewModel)
    }

    public func makeExchangeRateDetailView(param: ExchangeRateDetailCoordinator.Params) -> UIViewController {
        // VM
        let viewModel = ExchangeRateDetailViewModel(param: param)
        // VC
        let view = ExchangeRateDetailView(viewModel: viewModel)

        return UIHostingController(rootView: view)
    }
}
