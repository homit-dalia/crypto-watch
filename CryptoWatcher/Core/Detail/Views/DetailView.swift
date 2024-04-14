//
//  DetailView.swift
//  CryptoWatcher
//
//  Created by Homit Dalia on 14/04/24.
//

import SwiftUI

struct LazyDetailView: View {
    
    @Binding var coin: CoinModel?
    
    var body: some View{
        if let coin = coin {
            DetailView(coin: coin)
        }
    }
}

struct DetailView: View {
    
    let coin: CoinModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    DetailView(coin: DeveloperPreview.instance.coin)
}
