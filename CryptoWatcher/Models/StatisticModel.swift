//
//  StatisticModel.swift
//  CryptoWatcher
//
//  Created by Homit Dalia on 29/03/24.
//

import Foundation

class StatisticModel: Identifiable {
    
    let id: String = UUID().uuidString
    let title: String
    let value: String
    let percentageChange: Double?
    
    init(title: String, value: String, percentageChange: Double? = nil) {
        self.title = title
        self.value = value
        self.percentageChange = percentageChange
    }
    
}
