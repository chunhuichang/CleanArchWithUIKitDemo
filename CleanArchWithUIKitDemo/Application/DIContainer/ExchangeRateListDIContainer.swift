//
//  ExchangeRateListDIContainer.swift
//  CleanArchWithUIKitDemo
//
//  Created by Jill Chang on 2024/8/26.
//

import SwiftUI
import UIKit

public final class ExchangeRateListDIContainer {
    public struct Dependencies {
        let loadDataLoader: DataServiceLoader
        public init(loadDataLoader: DataServiceLoader) {
            self.loadDataLoader = loadDataLoader
        }
    }

    private let dependencies: Dependencies

    public init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    // MARK: - Flow Coordinators

    public func makeExchangeRateListCoordinator(navigationController: UINavigationController) -> ExchangeRateListCoordinator {
        ExchangeRateListCoordinator(navigationController: navigationController, dependencies: self)
    }
}

/// make DIContainer or ViewController
public protocol ExchangeRateListCoordinatorDependencies {
    func makeExchangeRateListViewController() -> UIViewController
    func makeExchangeRateListView() -> UIViewController
    func makeExchangeRateDetailDIContainer() -> ExchangeRateDetailDIContainer
}

extension ExchangeRateListDIContainer: ExchangeRateListCoordinatorDependencies {
    public func makeExchangeRateListView() -> UIViewController {
        // Data layer
        let repository = MainExchangeRateListRepository(loadDataLoader: dependencies.loadDataLoader)
        // Mock
        // let repository = MockExchangeRateListRepository()

        // Domain layer
        let usecase = MainExchangeRateListUseCase(repository: repository)

        // Presentation layer
        let vm = ListViewModel(usecase: usecase)

        let view = ExchangeRateListView(viewModel: vm)

        return UIHostingController(rootView: view)
    }

    public func makeExchangeRateListViewController() -> UIViewController {
        // Data layer
        let repository = MainExchangeRateListRepository(loadDataLoader: dependencies.loadDataLoader)
        // Mock
//        let repository = MockExchangeRateListRepository()

        // Domain layer
        let usecase = MainExchangeRateListUseCase(repository: repository)

        // Presentation layer
        let vm = ExchangeRateListViewModel(usecase)

        let view = ExchangeRateListViewController(viewModel: vm)
        return view
    }

    public func makeExchangeRateDetailDIContainer() -> ExchangeRateDetailDIContainer {
        ExchangeRateDetailDIContainer()
    }
}
