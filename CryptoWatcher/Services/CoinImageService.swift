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
    private let fileManger = LocalFileManager.instance
    private let folderName = "currency_images"
    private let imageName: String
    
    init(coin: CoinModel){
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }
    
    private func getCoinImage() {
        if let receivedImage = fileManger.getImage(imageName: imageName, folderName: folderName) {
            image = receivedImage
            print("Found saved image")
        }
        else {
            downloadImage()
            print("Downloading Image")
        }
    }
    
    private func downloadImage() {
        guard let url = URL(string: coin.image) else { return }
        
        imageSubscription = NetworkingManager.download(url: url)
            .receive(on: DispatchQueue.main)
            .tryMap({ data -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] receivedImage in
                guard let self = self, let downloadedImage = receivedImage else {return}
                self.image = downloadedImage
                self.imageSubscription?.cancel()
                self.fileManger.saveImage(image: downloadedImage, imageName: self.imageName, folderName: self.folderName)
            })
            
    }
    
}
