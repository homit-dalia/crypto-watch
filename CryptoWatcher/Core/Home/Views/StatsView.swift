//
//  StatsView.swift
//  CryptoWatcher
//
//  Created by Homit Dalia on 29/03/24.
//

import SwiftUI

struct StatsView: View {
    
    @State var type: StatType
    
    let marketStatistics: [StatisticModel] = [
        StatisticModel(title: "Title", value: "Value", percentageChange: 1),
        StatisticModel(title: "Title", value: "Value"),
        StatisticModel(title: "Title", value: "Value"),
    ]
    
    let userStatistics: StatisticModel = StatisticModel(title: "Holdings", value: "$23.22M", percentageChange: 21)
    
    var body: some View {
        if type == .market{
            HStack {
                ForEach(marketStatistics) { stat in
                    StatisticView(stat: stat, type: .market)
                        .frame(width: UIScreen.main.bounds.size.width / 3)
                }
            }
            .frame(width: UIScreen.main.bounds.size.width, alignment: .leading)
        }
        else if type == .user{
            StatisticView(stat: userStatistics, type: .user)
        }
    }
}

enum StatType {
    case market, user
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView(type: .user)
    }
}
