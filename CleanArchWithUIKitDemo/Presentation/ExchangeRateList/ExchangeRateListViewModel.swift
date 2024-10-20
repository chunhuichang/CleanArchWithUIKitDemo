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
    func triggerFetchData()
    func didSelectRowAt(_ row: Int)
}

// Output
public protocol ExchangeRateListVMOutput {
    var rateEntityPublisher: Published<ExchangeRateEntity?>.Publisher { get }
    var isLoadingProgressPublisher: Published<Bool>.Publisher { get }
    var isLoadingRefreshPublisher: Published<Bool>.Publisher { get }

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

public final class ExchangeRateListViewModel: ObservableObject, ExchangeRateListVMManager, ExchangeRateListVMOutput {
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

    @Published private(set) var rateEntity: ExchangeRateEntity? = nil
    @Published private(set) var isLoadingProgress: Bool = false
    @Published private(set) var isLoadingRefresh: Bool = false
    @Published private(set) var alertMessage: (title: String, message: String)? = nil

    // Output
    public var rateEntityPublisher: Published<ExchangeRateEntity?>.Publisher {
        $rateEntity
    }

    public var isLoadingProgressPublisher: Published<Bool>.Publisher {
        $isLoadingProgress
    }

    public var isLoadingRefreshPublisher: Published<Bool>.Publisher {
        $isLoadingRefresh
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
        fetchData(userInitiated: false)
    }

    public func triggerFetchData() {
        fetchData(userInitiated: true)
    }

    private func fetchData(userInitiated: Bool) {
        Task {
            await fetchData(userInitiated: userInitiated)
        }
    }

    public func fetchData(userInitiated: Bool = true) async {
        await MainActor.run {
            setLoadingState(isLoading: true, userInitiated: userInitiated)
        }

        let result = await usecase.exchangeRateList(with: .USD)
        await MainActor.run {
            setLoadingState(isLoading: false, userInitiated: userInitiated)
        }
        switch result {
        case .success(let entity):
            await MainActor.run {
                self.rateEntity = entity
            }
        case .failure(let error):
            await MainActor.run {
                alertMessage = (title: "Error", message: error.localizedDescription)
            }
        }
    }

    private func setLoadingState(isLoading: Bool, userInitiated: Bool) {
        switch (isLoading, userInitiated) {
        case (_, false):
            isLoadingProgress = isLoading
        case (_, true):
            isLoadingRefresh = isLoading
        }
    }

    public func didSelectRowAt(_ row: Int) {
        guard let rate = rateEntity?.rates[row] else {
            return
        }
        goToDetail(rate)
    }

    public func onTapGesture(_ rate: ExchangeRateEntity.RateEntity) {
        goToDetail(rate)
    }

    private func goToDetail(_ rate: ExchangeRateEntity.RateEntity) {
        delegate?.goToDetail(rate: rate)
    }
}
