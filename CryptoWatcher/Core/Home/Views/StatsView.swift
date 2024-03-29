//
//  StatsView.swift
//  CryptoWatcher
//
//  Created by Homit Dalia on 29/03/24.
//

import SwiftUI

struct StatsView: View {
    
    var type: StatType
    var statistics: [StatisticModel]
    
    var body: some View {
        if type == .market {
            HStack {
                ForEach(statistics) { stat in
                    StatisticView(stat: stat, type: .market)
                        .frame(width: UIScreen.main.bounds.size.width / 3)
                }
            }
            .frame(width: UIScreen.main.bounds.size.width, alignment: .leading)
        }
        else if type == .user {
            if !statistics.isEmpty {
                StatisticView(stat: statistics[0], type: .user)
            }
        }
    }
}

enum StatType {
    case market, user
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView(type: .market, statistics: [DeveloperPreview.instance.stat1, DeveloperPreview.instance.stat2, DeveloperPreview.instance.stat3])
            .previewLayout(.sizeThatFits)
    }
}
