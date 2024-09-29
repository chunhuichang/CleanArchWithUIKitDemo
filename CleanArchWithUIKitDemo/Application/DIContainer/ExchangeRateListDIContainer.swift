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
    private let view: PresentationView

    public init(dependencies: Dependencies, view: PresentationView) {
        self.dependencies = dependencies
        self.view = view
    }

    // MARK: - Flow Coordinators

    public func makeExchangeRateListCoordinator(navigationController: UINavigationController) -> ExchangeRateListCoordinator {
        ExchangeRateListCoordinator(navigationController: navigationController, dependencies: self, param: ExchangeRateListCoordinator.Params(view: view))
    }
}

/// make DIContainer or ViewController
public protocol ExchangeRateListCoordinatorDependencies {
    func makeExchangeRateListViewController(delegate: ExchangeRateListViewModelDelegate?) -> UIViewController
    func makeExchangeRateListView(delegate: ExchangeRateListViewModelDelegate?) -> UIViewController
    func makeExchangeRateDetailDIContainer() -> ExchangeRateDetailDIContainer
}

extension ExchangeRateListDIContainer: ExchangeRateListCoordinatorDependencies {
    public func makeExchangeRateListView(delegate: ExchangeRateListViewModelDelegate?) -> UIViewController {
        // Data layer
        let repository = MainExchangeRateListRepository(loadDataLoader: dependencies.loadDataLoader)
        // Mock
        // let repository = MockExchangeRateListRepository()

        // Domain layer
        let usecase = MainExchangeRateListUseCase(repository: repository)

        // Presentation layer
        let vm = ExchangeRateListViewModel(usecase)
        vm.delegate = delegate

        let view = ExchangeRateListView(viewModel: vm)

        return UIHostingController(rootView: view)
    }

    public func makeExchangeRateListViewController(delegate: ExchangeRateListViewModelDelegate?) -> UIViewController {
        // Data layer
        let repository = MainExchangeRateListRepository(loadDataLoader: dependencies.loadDataLoader)
        // Mock
//        let repository = MockExchangeRateListRepository()

        // Domain layer
        let usecase = MainExchangeRateListUseCase(repository: repository)

        // Presentation layer
        let vm = ExchangeRateListViewModel(usecase)
        vm.delegate = delegate

        let view = ExchangeRateListViewController(viewModel: vm)
        return view
    }

    public func makeExchangeRateDetailDIContainer() -> ExchangeRateDetailDIContainer {
        ExchangeRateDetailDIContainer()
    }
}
