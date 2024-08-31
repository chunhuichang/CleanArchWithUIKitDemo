//
//  ExchangeRateDetailViewController.swift
//  CleanArchWithUIKitDemo
//
//  Created by Jill Chang on 2024/8/31.
//

import Combine
import UIKit

public final class ExchangeRateDetailViewController: UIViewController {
    public let viewModel: ExchangeRateDetailViewModel
    private var cancellables = Set<AnyCancellable>()

    private lazy var currencyLabel: UILabel = createCurrencyLabel()
    private lazy var rateLabel: UILabel = createRateLabel()

    public init(viewModel: ExchangeRateDetailViewModel) {
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
        self.viewModel.viewWillDisappear()
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
        self.viewModel.$rateEntity
            .receive(on: DispatchQueue.main)
            .sink { [weak self] entity in
                self?.currencyLabel.text = entity?.currencyText
                self?.rateLabel.text = entity?.rateText
            }
            .store(in: &self.cancellables)
    }
}
