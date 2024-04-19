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
    @State var showFullDescription: Bool = false
    
    init(coin: CoinModel) {
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                ChartView(coin: vm.coin)
                descriptionView
                ContentView(title: "Overview", content: vm.overviewStatistics)
                Divider()
                ContentView(title: "Additional Information", content: vm.additionalStatistics)
                websiteView
            }
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                   toolBarTopTrailingView
                }
            })
            .padding()
        }
        .navigationTitle(vm.coin.name)
    }
}

extension DetailView {
    
    private struct ContentView: View {
        
        let title: String
        let content: [StatisticModel]
        
        private let columns: [GridItem] = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
        
        var body: some View {
            VStack{
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
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    var descriptionView: some View {
        VStack {
            Text(vm.description ?? "Loading...")
                .lineLimit(showFullDescription ? nil : 3)
                .font(.body)
                .foregroundStyle(Color.theme.secondaryText)
            Button(action: {
                withAnimation(.smooth) {
                    showFullDescription.toggle()
                }
            }, label: {
                Text(showFullDescription ? "Less" : "Show more...")
                    .font(.caption)
                    .bold()
                    .foregroundStyle(.blue)
                    .padding(.vertical, 4)
                    .frame(alignment: .leading)
            })
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    var websiteView: some View {
        VStack(alignment: .leading, spacing: 20) {
            if let website = vm.websiteURL {
                HStack(spacing: 8) {
                    Image(systemName: "safari")
                    Link(destination: URL(string: website)!, label: {
                        Text("Website")
                    })
                }
            }
            if let reddit = vm.redditURL {
                HStack(spacing: 8) {
                    Image(systemName: "face.dashed")
                    Link(destination: URL(string: reddit)!, label: {
                        Text("Reddit")
                    })
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    var toolBarTopTrailingView: some View {
        HStack {
            Text(vm.coin.symbol.uppercased())
                .font(.callout)
            CoinImageView(coin: vm.coin)
                .frame(width: 20, height: 20)
        }
    }
}
#Preview {
    NavigationView{
        DetailView(coin: DeveloperPreview.instance.coin)
    }
}
