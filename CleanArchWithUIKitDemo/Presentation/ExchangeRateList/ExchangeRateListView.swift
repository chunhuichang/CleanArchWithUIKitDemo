//
//  ExchangeRateListView.swift
//  CleanArchWithUIKitDemo
//
//  Created by Jill Chang on 2024/9/20.
//

import SwiftUI

struct ExchangeRateListView: View {
    @ObservedObject var viewModel: ListViewModel

    var body: some View {
        List(viewModel.items) { item in
            VStack(alignment: .leading, spacing: 3) {
                Text(item.currencyText)
                    .foregroundColor(.primary)
                    .font(.headline)
                HStack {
                    Label(item.rateText, systemImage: "dollarsign.bank.building")
                }
                .foregroundColor(.secondary)
                .font(.subheadline)
            }
        }
    }
}

#Preview {
    ExchangeRateListView(viewModel: ListViewModel(usecase: MockExchangeRateListUseCase()))
}

import Combine

class ListViewModel: ObservableObject {
    @Published var items: [ExchangeRateEntity.RateEntity] = []
    private let usecase: ExchangeRateListUseCase

    init(usecase: ExchangeRateListUseCase) {
        self.usecase = usecase
        fetchItems()
    }

    func fetchItems() {
        Task {
            let result = await usecase.exchangeRateList(with: .USD)
            switch result {
            case .success(let entity):
                items = entity.rates
            case .failure(let error):
                // TODO: implement error
                print("Error: \(error)")
            }
        }
    }
}
