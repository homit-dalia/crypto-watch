//
//  CoinDataService.swift
//  CryptoWatcher
//
//  Created by Homit Dalia on 20/03/24.
//

import Foundation
import Combine

class CoinDataService {
    
    @Published var allCoins: [CoinModel] = []
    
    var coinSubscription: AnyCancellable?
    let jsonDecoder = JSONDecoder()
    
    init() {
        getCoins()
    }
    
    func getCoins() {
        guard let url = URL(string:        "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=25&page=1&sparkline=true&price_change_percentage=24h") else { return }
        
        coinSubscription = NetworkingManager.download(url: url)
            .receive(on: DispatchQueue.main)
            .decode(type: [CoinModel].self, decoder: jsonDecoder)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] receivedCoins in
                self?.allCoins = receivedCoins
                self?.coinSubscription?.cancel()
            })
            
    }
    
}
