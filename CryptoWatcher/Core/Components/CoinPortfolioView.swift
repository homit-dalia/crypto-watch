//
//  CoinPortfolioView.swift
//  CryptoWatcher
//
//  Created by Homit Dalia on 03/04/24.
//

import SwiftUI

struct CoinPortfolioView: View {
    
    let coin: CoinModel
    
    var body: some View {
        VStack{
            CoinImageView(coin: coin)
                .frame(width: 50, height: 50)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .foregroundStyle(Color.theme.accent)
                .lineLimit(1)
            Text(coin.name)
                .font(.subheadline)
                .foregroundStyle(Color.theme.secondaryText)
                .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
        }
    }
}

#Preview {
    CoinPortfolioView(coin: DeveloperPreview.instance.coin)
}
