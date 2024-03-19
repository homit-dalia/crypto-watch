//
//  HomeViewModel.swift
//  CryptoWatcher
//
//  Created by Homit Dalia on 18/03/24.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    @Published var allCoins: [CoinModel] = []
    @Published var allPortfolio: [CoinModel] = []
    
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01){
            self.allCoins.append(DeveloperPreview.instance.coin)
            self.allPortfolio.append(DeveloperPreview.instance.coin)
        }
    }
}
