//
//  CoinImageService.swift
//  CryptoWatcher
//
//  Created by Homit Dalia on 22/03/24.
//

import Foundation
import SwiftUI
import Combine

class CoinImageService {
    
    @Published var image: UIImage?
    
    private var imageSubscription: AnyCancellable?
    private let coin: CoinModel
    
    init(coin: CoinModel){
        self.coin = coin
        getCoinImage()
    }
    
    private func getCoinImage() {
        guard let url = URL(string: coin.image) else { return }
        
        imageSubscription = NetworkingManager.download(url: url)
            .receive(on: DispatchQueue.main)
            .tryMap({ data -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] receivedImage in
                self?.image = receivedImage
                self?.imageSubscription?.cancel()
            })
            
    }
    
}
