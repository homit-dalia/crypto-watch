//
//  StatisticView.swift
//  CryptoWatcher
//
//  Created by Homit Dalia on 29/03/24.
//

import SwiftUI

struct StatisticView: View {
    
    let stat: StatisticModel
    let type: StatType
    
    var body: some View {
        if type == .market{
            VStack(alignment: .center, spacing: 4) {
                Text(stat.title)
                    .font(.caption)
                    .foregroundStyle(Color.theme.secondaryText)
                Text(stat.value)
                    .font(.headline)
                    .foregroundStyle(Color.theme.accent)
                if stat.percentageChange?.asPercentString() ?? nil != nil {
                    HStack(spacing: 4){
                        Image(systemName: "triangle.fill")
                            .font(.caption2)
                            .rotationEffect(
                                Angle(degrees: (stat.percentageChange ?? 0) >= 0 ? 0 : 180))
                        Text(stat.percentageChange?.asPercentString() ?? "")
                            .font(.caption)
                            .bold()
                    }
                    .foregroundStyle((stat.percentageChange ?? 0) > 0 ? Color.theme.green : Color.theme.red)
                }
            }
        }
        else if type == .user{
            HStack {
                Spacer()
                Text(stat.title)
                    .font(.title2)
                    .foregroundStyle(Color.theme.accent)
                    .bold()
                Spacer()
                VStack{
                    Text(stat.value)
                        .font(.title3)
                        .bold()
                    if stat.percentageChange?.asPercentString() ?? nil != nil {
                        HStack(spacing: 4){
                            Image(systemName: "triangle.fill")
                                .font(.caption)
                                .rotationEffect(
                                    Angle(degrees: (stat.percentageChange ?? 0) >= 0 ? 0 : 180))
                            Text(stat.percentageChange?.asPercentString() ?? "")
                                .font(.caption)
                                .bold()
                        }
                        .foregroundStyle((stat.percentageChange ?? 0) > 0 ? Color.theme.green : Color.theme.red)
                    }
                }
                Spacer()
            }
        }
    }
}

struct StatisticView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            StatisticView(stat: DeveloperPreview.instance.stat1, type: .market)
                .previewLayout(.sizeThatFits)
            StatisticView(stat: DeveloperPreview.instance.stat3, type: .user)
                .previewLayout(.sizeThatFits)
        }
    }
}
