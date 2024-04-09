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
    @Published var isCoinDataLoading: Bool = true
    
    @Published var searchTextCurrencies: String = ""
    @Published var searchTextPortfolio: String = ""
    
    @Published var isStatisticsLoading: Bool = true
    @Published var marketStatistics: [StatisticModel] = []
    @Published var userStatistics: [StatisticModel] = []
    
    @Published var allCoins: [CoinModel] = []
    @Published var allPortfolio: [CoinModel] = []
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    private func addSubscribers() {
        $searchTextCurrencies
            .combineLatest(coinDataService.$allCoins)
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] receivedValue in
                self?.allCoins = receivedValue
                self?.isCoinDataLoading = false
            }
            .store(in: &cancellables)
        
        marketDataService.$marketData
            .combineLatest(portfolioDataService.$totalHoldings)
            .map(mapGlobalMarketData)
            .sink { [weak self] (returnedStatistics) in
                self?.marketStatistics = Array(returnedStatistics.prefix(3))
                self?.userStatistics = Array(returnedStatistics.dropFirst(3))
                self?.isStatisticsLoading = false
            }
            .store(in: &cancellables)
        
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map {(coins, entities) -> [CoinModel] in
                coins
                    .compactMap { (coin) -> CoinModel? in
                        if let entity = entities.first(where: {$0.coinID == coin.id}) {
                            return coin.updateHoldings(amount: entity.amount)
                        }
                        return nil
                    }
            }
            .sink { [weak self] (returnedCoins) in
                self?.allPortfolio = returnedCoins
            }
            .store(in: &cancellables)
    }
    
    func updatePortfolio(coin: CoinModel, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
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
    
    private func mapGlobalMarketData(marketDataModel: MarketDataModel?, totalHoldings: Double) -> [StatisticModel] {
        
        var stats: [StatisticModel] = []
        guard let data = marketDataModel else {return stats}
        stats.append(contentsOf: [
            StatisticModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd),
            StatisticModel(title: "Volume", value: data.volume),
            StatisticModel(title: "BTC Mkt. %", value: data.btcDominance),
            StatisticModel(title: "Holdings", value: String(totalHoldings), percentageChange:0)
        ])
        return stats
    }
}


