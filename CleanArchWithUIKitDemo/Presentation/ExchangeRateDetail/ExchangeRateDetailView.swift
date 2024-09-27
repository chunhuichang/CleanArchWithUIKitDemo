//
//  ExchangeRateDetailView.swift
//  CleanArchWithUIKitDemo
//
//  Created by Jill Chang on 2024/9/27.
//

import SwiftUI

struct ExchangeRateDetailView: View {
    @ObservedObject var viewModel: ExchangeRateDetailViewModel

    var body: some View {
        VStack {
            Text(viewModel.currencyText)
                .font(.system(size: 34.0))
                .foregroundStyle(.black.opacity(0.5))
                .padding(.vertical, 48)
            Text(viewModel.rateText)
                .font(.system(size: 24.0))
                .foregroundStyle(.tint.opacity(0.7))
            Spacer()
        }
    }
}

#Preview {
    ExchangeRateDetailView(viewModel: ExchangeRateDetailViewModel(param: ExchangeRateDetailCoordinator.Params(rateEntity: ExchangeRateEntity.RateEntity.mockValue)))
}
