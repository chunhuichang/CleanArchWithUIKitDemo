//
//  ExchangeRateListViewModel.swift
//  CleanArchWithUIKitDemo
//
//  Created by Jill Chang on 2024/8/22.
//

import Foundation

// Input
public protocol ExchangeRateListVMInput {
    func viewDidLoad()
    func didSelectRowAt(_ row: Int)
}

// Output
public protocol ExchangeRateListVMOutput {
    var rateEntity: ExchangeRateEntity? { get }
    var isLoading: Bool { get }
    var alertMessage: (title: String, message: String)? { get }
}

public protocol ExchangeRateListViewModelDelegate: AnyObject {
    func goToDetail(rate: ExchangeRateEntity.RateEntity)
}

public final class ExchangeRateListViewModel: ExchangeRateListVMOutput {
    private let usecase: ExchangeRateListUseCase
    public weak var delegate: ExchangeRateListViewModelDelegate?

    public init(_ usecase: ExchangeRateListUseCase) {
        self.usecase = usecase
    }

    // output
    @Published public var rateEntity: ExchangeRateEntity? = nil
    @Published public var isLoading: Bool = false
    @Published public var alertMessage: (title: String, message: String)? = nil
}

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
