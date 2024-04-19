//
//  DetailViewModel.swift
//  CryptoWatcher
//
//  Created by Homit Dalia on 14/04/24.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    
    @Published var overviewStatistics: [StatisticModel] = []
    @Published var additionalStatistics: [StatisticModel] = []
    
    @Published var description: String? = ""
    @Published var websiteURL: String? = ""
    @Published var redditURL: String? = ""

    @Published var coin: CoinModel
    private let coinDetailService: CoinDetailService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: CoinModel){
        self.coin = coin
        self.coinDetailService = CoinDetailService(coin: coin)
        self.addSubscribers()
    }
    
    private func addSubscribers() {
        
        coinDetailService.$detail
            .combineLatest($coin)
            .map({(coinDetailModel, coinModel) -> (overviewStats: [StatisticModel], additionalStats: [StatisticModel], description: String?, websiteURL: String?, redditURL: String?) in
                
                let price = coinModel.currentPrice.asCurrencyWith6Decimals()
                let priceChange = coinModel.priceChangePercentage24H
                let priceStat = StatisticModel(title: "Current Price", value: price, percentageChange: priceChange)
                
                let marketCap = "$" + (coinModel.marketCap?.formattedWithAbbreviations () ?? "")
                let marketCapChange = coinModel.marketCapChangePercentage24H
                let marketCapStat = StatisticModel(title: "Market Capitalization", value: marketCap, percentageChange: marketCapChange)
                
                let rank = "\(coinModel.rank)"
                let rankStat = StatisticModel(title: "Rank", value: rank)
                
                let volume = "$" + (coinModel.totalVolume?.formattedWithAbbreviations () ?? "")
                let volumeStat = StatisticModel(title: "Volume", value: volume)
                
                let overviewArray: [StatisticModel] = [priceStat, marketCapStat, rankStat, volumeStat]
                
                let high = coinModel.high24H?.asCurrencyWith6Decimals() ?? "n/a"
                let highStat = StatisticModel(title: "24h High", value: high)
                
                let low = coinModel.low24H?.asCurrencyWith6Decimals() ?? "n/a"
                let lowStat = StatisticModel(title: "24h Low", value: low)
                
                let priceChange2 = coinModel.priceChange24H?.asCurrencyWith6Decimals() ?? "n/a"
                let pricePercentChange2 = coinModel.priceChangePercentage24H
                let priceChangeStat = StatisticModel(title: "24h Price Change", value: priceChange2, percentageChange: pricePercentChange2)
                
                let marketCapChange2 = "$" + (coinModel.marketCapChange24H?.formattedWithAbbreviations() ?? "")
                let marketCapPercentChange2 = coinModel.marketCapChangePercentage24H
                let marketCapChangeStat = StatisticModel(title: "24h Market Cap Change", value: marketCapChange2, percentageChange:
                                                            marketCapPercentChange2)
                
                let blockTime = coinDetailModel?.blockTimeInMinutes ?? 0
                let blockTimeString = blockTime == 0 ? "n/a" : "\(blockTime)"
                let blockStat = StatisticModel(title: "Block Time", value: blockTimeString)
                
                let hashing = coinDetailModel?.hashingAlgorithm ?? "n/a"
                let hashingStat = StatisticModel(title: "Hashing Algorithm", value: hashing)
                
                let additionalArray: [StatisticModel] = [ highStat, lowStat, priceChangeStat, marketCapChangeStat, blockStat, hashingStat]
                
                let description: String? = coinDetailModel?.readableDescription
                let websiteURL: String? = coinDetailModel?.links?.homepage?.first
                let redditURL: String? = coinDetailModel?.links?.subredditURL
                
                return (overviewArray, additionalArray, description, websiteURL, redditURL)
                
            })
            .sink{ [weak self] returnedArrays in
                self?.overviewStatistics = returnedArrays.overviewStats
                self?.additionalStatistics = returnedArrays.additionalStats
                self?.description = returnedArrays.description
                self?.websiteURL = returnedArrays.websiteURL
                self?.redditURL = returnedArrays.redditURL

            }
            .store(in: &cancellables)
    }
    
}
