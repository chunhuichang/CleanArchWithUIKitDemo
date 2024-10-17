//
//  ExchangeRateListView.swift
//  CleanArchWithUIKitDemo
//
//  Created by Jill Chang on 2024/9/20.
//

import SwiftUI

public struct ExchangeRateListView: View {
    @ObservedObject var viewModel: ExchangeRateListViewModel

    public var body: some View {
        List(viewModel.rateEntity?.rates ?? []) { item in
            HStack {
                VStack(alignment: .leading) {
                    Text(item.currencyText)
                        .foregroundColor(.primary)
                        .font(.headline)
                    HStack {
                        Label(item.rateText, systemImage: "dollarsign.bank.building")
                    }
                    .foregroundColor(.secondary)
                    .font(.subheadline)
                }
                Spacer()
            }
            .contentShape(Rectangle())
            .onTapGesture {
                viewModel.onTapGesture(item)
            }
        }
        .onAppear {
            viewModel.input.viewDidLoad()
        }
        .refreshable {
            await viewModel.fetchData()
        }
    }
}

#Preview {
    ExchangeRateListView(viewModel: ExchangeRateListViewModel(MockExchangeRateListUseCase()))
}
