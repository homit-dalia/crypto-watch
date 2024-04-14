//
//  CoinDetailService.swift
//  CryptoWatcher
//
//  Created by Homit Dalia on 14/04/24.
//

import Foundation
import Combine

class CoinDetailService {
    
    @Published var detail: CoinDetailModel? = nil
    let coin: CoinModel
    
    var coinDetailSubscription: AnyCancellable?
    let jsonDecoder = JSONDecoder()
    
    init(coin: CoinModel) {
        self.coin = coin
        getDetail()
    }
    
    
    func getDetail() {
        guard let url = URL(string:"https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&develo er_data=false&sparkline=false") else { return }
        
        coinDetailSubscription = NetworkingManager.download(url: url)
            .receive(on: DispatchQueue.main)
            .decode(type: CoinDetailModel.self, decoder: jsonDecoder)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] receivedDetail in
                self?.detail = receivedDetail
                self?.coinDetailSubscription?.cancel()
            })
            
    }
    
}
