//
//  ExchangeRateListView.swift
//  CleanArchWithUIKitDemo
//
//  Created by Jill Chang on 2024/9/20.
//

import SwiftUI

struct ExchangeRateListView: View {
    @ObservedObject var viewModel: ExchangeRateListViewModel

    var body: some View {
        List(viewModel.rateEntity?.rates ?? []) { item in
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
        .onAppear {
            viewModel.input.viewDidLoad()
        }
    }
}

#Preview {
    ExchangeRateListView(viewModel: ExchangeRateListViewModel(MockExchangeRateListUseCase()))
}
