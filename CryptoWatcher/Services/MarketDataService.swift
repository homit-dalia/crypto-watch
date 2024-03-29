//
//  MarketDataService.swift
//  CryptoWatcher
//
//  Created by Homit Dalia on 29/03/24.
//

import Foundation
import Combine

class MarketDataService {
    
    @Published var marketData: MarketDataModel? = nil
    
    var marketSubscription: AnyCancellable?
    let jsonDecoder = JSONDecoder()
    
    init() {
        getMarketData()
    }
    
    private func getMarketData() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else { return }
        
        marketSubscription = NetworkingManager.download(url: url)
            .receive(on: DispatchQueue.main)
            .decode(type: GlobalData.self, decoder: jsonDecoder)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (receivedMarketData) in
                self?.marketData = receivedMarketData.data
                self?.marketSubscription?.cancel()
            })
        
    }
    
}
