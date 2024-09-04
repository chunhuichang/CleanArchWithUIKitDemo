//
//  ExchangeRateDetailViewModel.swift
//  CleanArchWithUIKitDemo
//
//  Created by Jill Chang on 2024/8/31.
//

import Combine
import Foundation

// Input
public protocol ExchangeRateDetailVMInput {
    func viewWillDisappear()
}

// Output
public protocol ExchangeRateDetailVMOutput {
    var currencyTextPublished: Published<String>.Publisher { get }
    var rateTextPublished: Published<String>.Publisher { get }
}

// Manager
public protocol ExchangeRateDetailVMManager: AnyObject {
    var delegate: ExchangeRateDetailViewModelDelegate? { get set }
    var input: ExchangeRateDetailVMInput { get }
    var output: ExchangeRateDetailVMOutput { get }
}

public protocol ExchangeRateDetailViewModelDelegate: AnyObject {
    func dismiss()
}

public final class ExchangeRateDetailViewModel: ExchangeRateDetailVMManager, ExchangeRateDetailVMOutput {
    public weak var delegate: ExchangeRateDetailViewModelDelegate?

    @Published private var currencyText: String
    @Published private var rateText: String

    public init(param: ExchangeRateDetailCoordinator.Params) {
        currencyText = param.rateEntity.currencyText
        rateText = param.rateEntity.rateText
    }

    public var input: ExchangeRateDetailVMInput {
        self
    }

    public var output: ExchangeRateDetailVMOutput {
        self
    }

    // Output
    public var currencyTextPublished: Published<String>.Publisher {
        $currencyText
    }

    public var rateTextPublished: Published<String>.Publisher {
        $rateText
    }
}

extension ExchangeRateDetailViewModel: ExchangeRateDetailVMInput {
    public func viewWillDisappear() {
        delegate?.dismiss()
    }
}
