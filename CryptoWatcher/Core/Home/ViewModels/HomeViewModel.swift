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
    @Published var isLoading: Bool = true
    @Published var searchTextCurrencies: String = ""
    @Published var searchTextPortfolio: String = ""
    @Published var allCoins: [CoinModel] = []
    @Published var allPortfolio: [CoinModel] = []
    
    private let coinService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    private func addSubscribers() {
        $searchTextCurrencies
            .combineLatest(coinService.$allCoins)
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] receivedValue in
                self?.allCoins = receivedValue
                self?.isLoading = false
            }
            .store(in: &cancellables)
    }
    
    
    private func filterCoins(searchText: String, coins: [CoinModel]) -> [CoinModel] {
        guard !searchText.isEmpty else {
            return coins
        }
        
        let lowercaseText = searchText.lowercased()
        
        return coins.filter { (coin) -> Bool in
            return coin.name.lowercased().contains(lowercaseText) || coin.id.lowercased().contains(lowercaseText) ||
            coin.symbol.lowercased().contains(lowercaseText)
        }
    }
}


