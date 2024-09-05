//
//  ExchangeRateListViewModel.swift
//  CleanArchWithUIKitDemo
//
//  Created by Jill Chang on 2024/8/22.
//

import Combine
import Foundation

// Input
public protocol ExchangeRateListVMInput {
    func viewDidLoad()
    func didSelectRowAt(_ row: Int)
}

// Output
public protocol ExchangeRateListVMOutput {
    var rateEntityPublisher: Published<ExchangeRateEntity?>.Publisher { get }
    var isLoadingPublisher: Published<Bool>.Publisher { get }
    var alertMessagePublisher: Published<(title: String, message: String)?>.Publisher { get }

    func numberOfRowsInSection(_ section: Int) -> Int
    func cellForRowAt(_ indexPath: IndexPath) -> ExchangeRateEntity.RateEntity?
}

// Manager
public protocol ExchangeRateListVMManager: AnyObject {
    var delegate: ExchangeRateListViewModelDelegate? { get set }
    var input: ExchangeRateListVMInput { get }
    var output: ExchangeRateListVMOutput { get }
}

public protocol ExchangeRateListViewModelDelegate: AnyObject {
    func goToDetail(rate: ExchangeRateEntity.RateEntity)
}

public final class ExchangeRateListViewModel: ExchangeRateListVMManager, ExchangeRateListVMOutput {
    private let usecase: ExchangeRateListUseCase
    public weak var delegate: ExchangeRateListViewModelDelegate?

    public init(_ usecase: ExchangeRateListUseCase) {
        self.usecase = usecase
    }

    public var input: ExchangeRateListVMInput {
        self
    }

    public var output: ExchangeRateListVMOutput {
        self
    }

    @Published private var rateEntity: ExchangeRateEntity? = nil
    @Published private var isLoading: Bool = false
    @Published private var alertMessage: (title: String, message: String)? = nil

    // Output
    public var rateEntityPublisher: Published<ExchangeRateEntity?>.Publisher {
        $rateEntity
    }

    public var isLoadingPublisher: Published<Bool>.Publisher {
        $isLoading
    }

    public var alertMessagePublisher: Published<(title: String, message: String)?>.Publisher {
        $alertMessage
    }
}

// MARK: - Output

public extension ExchangeRateListViewModel {
    func numberOfRowsInSection(_ section: Int) -> Int {
        rateEntity?.rates.count ?? 0
    }

    func cellForRowAt(_ indexPath: IndexPath) -> ExchangeRateEntity.RateEntity? {
        rateEntity?.rates[indexPath.row]
    }
}

// MARK: - Input

extension ExchangeRateListViewModel: ExchangeRateListVMInput {
    public func viewDidLoad() {
        Task {
            isLoading = true
            let result = await usecase.exchangeRateList(with: .USD)
            isLoading = false
            switch result {
            case .success(let entity):
                rateEntity = entity
            case .failure(let error):
                alertMessage = (title: "Error", message: error.localizedDescription)
            }
        }
    }

    public func didSelectRowAt(_ row: Int) {
        guard let rate = rateEntity?.rates[row] else {
            return
        }
        delegate?.goToDetail(rate: rate)
    }
}
