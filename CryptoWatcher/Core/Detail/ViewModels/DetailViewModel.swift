//
//  DetailViewModel.swift
//  CryptoWatcher
//
//  Created by Homit Dalia on 14/04/24.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    
    private let coinDetailService: CoinDetailService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: CoinModel){
        self.coinDetailService = CoinDetailService(coin: coin)
        self.addSubscribers()
    }
    
    private func addSubscribers() {
        
        coinDetailService.$detail
            .sink { receivedDetail in
                print("Initialized Details for \(receivedDetail?.name)")
            }
            .store(in: &cancellables)
    }
    
}
