//
//  ExchangeRateDetailViewModel.swift
//  CleanArchWithUIKitDemo
//
//  Created by Jill Chang on 2024/8/31.
//

import Foundation

// Input
public protocol ExchangeRateDetailVMInput {
    func viewWillDisappear()
}

// Output
public protocol ExchangeRateDetailVMOutput {
    var rateEntity: ExchangeRateEntity.RateEntity? { get }
}

public protocol ExchangeRateDetailViewModelDelegate: AnyObject {
    func dismiss()
}

public final class ExchangeRateDetailViewModel: ExchangeRateDetailVMOutput {
    public weak var delegate: ExchangeRateDetailViewModelDelegate?

    public init(param: ExchangeRateDetailCoordinator.Params) {
        self.rateEntity = param.rateEntity
    }

    // output
    @Published public var rateEntity: ExchangeRateEntity.RateEntity? = nil
}

extension ExchangeRateDetailViewModel: ExchangeRateDetailVMInput {
    public func viewWillDisappear() {
        delegate?.dismiss()
    }
}
