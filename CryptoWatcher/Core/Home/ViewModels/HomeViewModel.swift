//
//  HomeViewModel.swift
//  CryptoWatcher
//
//  Created by Homit Dalia on 18/03/24.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var selectedTab = 0
    @Published var allCoins: [CoinModel] = []
    @Published var allPortfolio: [CoinModel] = []
    
    private let coinService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    private func addSubscribers() {
        coinService.$allCoins
            .sink { receivedCoins in
                self.allCoins = receivedCoins
            }
            .store(in: &cancellables)
    }
}
