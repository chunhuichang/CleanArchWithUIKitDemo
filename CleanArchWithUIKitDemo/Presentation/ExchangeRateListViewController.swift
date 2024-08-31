//
//  ExchangeRateListViewController.swift
//  CleanArchWithUIKitDemo
//
//  Created by Jill Chang on 2024/8/22.
//

import Combine
import UIKit

public final class ExchangeRateListViewController: UIViewController {
    public let viewModel: ExchangeRateListViewModel

    private var cancellables = Set<AnyCancellable>()

    public lazy var tableView: UITableView = createTableView()

    public init(viewModel: ExchangeRateListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
        self.bindViewModel()
        self.viewModel.viewDidLoad()
    }
}

extension ExchangeRateListViewController: UITableViewDelegate {}

extension ExchangeRateListViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.rateEntity?.rates.count ?? 0
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RateCell", for: indexPath)
        let row = self.viewModel.rateEntity?.rates[indexPath.row]

        var content = cell.defaultContentConfiguration()
        content.text = row?.currencyText
        content.secondaryText = row?.rateText
        cell.contentConfiguration = content
        return cell
    }
}

// MARK: UI Setting

private extension ExchangeRateListViewController {
    func setupUI() {
        self.view.backgroundColor = .white
        self.view.addSubview(self.tableView)

        let s = self.view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: s.topAnchor, constant: 24.0),
            self.tableView.leadingAnchor.constraint(equalTo: s.leadingAnchor, constant: 24.0),
            self.tableView.trailingAnchor.constraint(equalTo: s.trailingAnchor, constant: -24.0),
            self.tableView.bottomAnchor.constraint(equalTo: s.bottomAnchor, constant: -24.0),
        ])
    }

    func createTableView() -> UITableView {
        let v = UITableView(frame: .zero, style: .plain)
        v.register(UITableViewCell.self, forCellReuseIdentifier: "RateCell")
        v.delegate = self
        v.dataSource = self
        v.translatesAutoresizingMaskIntoConstraints = false

        return v
    }

    func showErrorAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

// MARK: UI Binding

private extension ExchangeRateListViewController {
    func bindViewModel() {
        self.viewModel.$rateEntity
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &self.cancellables)

        self.viewModel.$alertMessage
            .compactMap { $0 }
            .sink { [weak self] msg in
                self?.showErrorAlert(title: msg.title, message: msg.message)
            }
            .store(in: &self.cancellables)
    }
}
