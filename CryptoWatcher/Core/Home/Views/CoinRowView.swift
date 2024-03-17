//
//  CoinRowView.swift
//  CryptoWatcher
//
//  Created by Homit Dalia on 17/03/24.
//

import SwiftUI

struct CoinRowView: View {
    
    let coin: CoinModel
    let showHoldingColumn: Bool
    
    var body: some View {
        HStack{
            Text("\(coin.rank)")
                .font(.title3)
                .foregroundStyle(Color.theme.accent)
            CoinImage(url: coin.image)
                .padding(.horizontal, 4)
            Text(coin.symbol.uppercased())
            if showHoldingColumn {
                Spacer()
                VStack{
                    Text(coin.currentHoldingsValue.asCurrencyWith2Decimals())
                        .font(.headline)
                        .fontWeight(.bold)
                    Text((coin.currentHoldings ?? 0).asNumberString())
                        .font(.subheadline)
                        .fontWeight(.medium)
                }
                Spacer()
            }
            else{
                Spacer()
            }
            VStack(alignment: .trailing){
                Text(coin.currentPrice.asCurrencyWith6Decimals())
                    .fontWeight(.bold)
                Text((coin.priceChangePercentage24H ?? 0).asPercentString())
                    .font(.callout)
                    .foregroundStyle(
                        (coin.priceChangePercentage24H ?? 0.00) > 0 ? Color.theme.green : Color.theme.red
                    )
            }
        }
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        CoinRowView(coin: dev.coin, showHoldingColumn: true)
            .previewLayout(.sizeThatFits)
            .padding(.horizontal, 16)
    }
}

struct CoinImage: View {
    
    let url : String
    let dimensions: CGFloat = 30
    
    var body: some View {
        AsyncImage(url: URL(string: url)) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: dimensions, height: dimensions) // Adjust size as needed
            default:
                Image(systemName: "error")
                    .resizable()
                    .scaledToFit()
                    .frame(width: dimensions, height: dimensions) // Placeholder image
            }
        }
    }
}
