//
//  DetailView.swift
//  CryptoWatcher
//
//  Created by Homit Dalia on 14/04/24.
//

import SwiftUI

struct LazyDetailView: View {
    
    @Binding var coin: CoinModel?
    
    var body: some View{
        if let coin = coin {
            DetailView(coin: coin)
        }
    }
}

struct DetailView: View {
    
    @StateObject var vm: DetailViewModel
    
    init(coin: CoinModel) {
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ChartView(coin: vm.coin)
                Divider()
                ContentView(title: "Overview", content: vm.overviewStatistics)
                Divider()
                ContentView(title: "Additional Information", content: vm.additionalStatistics)
            }
        }
        .padding()
        .navigationTitle(vm.coin.name)
    }
}

extension DetailView {
    
    struct ContentView: View {
        
        let title: String
        let content: [StatisticModel]
        
        private let columns: [GridItem] = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
        
        var body: some View {
            Text(title)
                .font(.title)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            LazyVGrid(columns: columns,
                      alignment: .leading,
                      spacing: 20,
                      content: {
                ForEach(content) { stats in
                    StatsView(type: .market, statistics: [stats])
                }
            })
        }
    }
    
    
}
#Preview {
    NavigationView{
        DetailView(coin: DeveloperPreview.instance.coin)
    }
}
