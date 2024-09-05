//
//  ExchangeRateDetailViewController.swift
//  CleanArchWithUIKitDemo
//
//  Created by Jill Chang on 2024/8/31.
//

import Combine
import UIKit

public final class ExchangeRateDetailViewController: UIViewController {
    public let viewModel: ExchangeRateDetailVMManager
    private var cancellables = Set<AnyCancellable>()

    public private(set) lazy var currencyLabel: UILabel = createCurrencyLabel()
    public private(set) lazy var rateLabel: UILabel = createRateLabel()

    public init(viewModel: ExchangeRateDetailVMManager) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        bindViewModel()
    }

    override public func viewWillDisappear(_ animated: Bool) {
        self.viewModel.input.viewWillDisappear()
    }
}

// MARK: UI Setting

private extension ExchangeRateDetailViewController {
    func setupUI() {
        self.view.backgroundColor = .white

        for view in [self.currencyLabel, self.rateLabel] {
            self.view.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }

        let s = self.view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            self.currencyLabel.topAnchor.constraint(equalTo: s.topAnchor, constant: 48.0),
            self.currencyLabel.centerXAnchor.constraint(equalTo: s.centerXAnchor),
            self.rateLabel.topAnchor.constraint(equalTo: self.currencyLabel.bottomAnchor, constant: 48.0),
            self.rateLabel.centerXAnchor.constraint(equalTo: s.centerXAnchor),
        ])
    }

    func createCurrencyLabel() -> UILabel {
        let l = UILabel()
        l.font = .systemFont(ofSize: 34.0)
        l.textColor = .black.withAlphaComponent(0.5)
        return l
    }

    func createRateLabel() -> UILabel {
        let l = UILabel()
        l.font = .systemFont(ofSize: 24.0)
        l.textColor = .tintColor.withAlphaComponent(0.7)
        return l
    }
}

// MARK: UI Binding

private extension ExchangeRateDetailViewController {
    func bindViewModel() {
        self.viewModel.output.currencyTextPublished
            .receive(on: DispatchQueue.main)
            .sink { [weak self] label in
                self?.currencyLabel.text = label
            }
            .store(in: &self.cancellables)

        self.viewModel.output.rateTextPublished
            .receive(on: DispatchQueue.main)
            .sink { [weak self] label in
                self?.rateLabel.text = label
            }
            .store(in: &self.cancellables)
    }
}
