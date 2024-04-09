//
//  PortfolioView.swift
//  CryptoWatcher
//
//  Created by Homit Dalia on 25/03/24.
//

import SwiftUI

struct PortfolioView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @State private var searchText: String = ""
    @State private var isAddPortfolioViewVisible: Bool = false
    
    var body: some View {
        HStack {
            List {
                Section() {
                    if vm.isStatisticsLoading {
                        ProgressView()
                    }
                    else {
                        StatsView(type: .user, statistics: vm.userStatistics)
                    }
                }
                .listRowSeparator(.hidden)
                ForEach(vm.allPortfolio) { coin in
                    CoinRowView(coin: coin, showHoldingColumn: true)
                }
            }
            .listStyle(.plain)
            .searchable(text: $vm.searchTextPortfolio)
            .autocorrectionDisabled()
        }
        .sheet(isPresented: $isAddPortfolioViewVisible, content: {
            AddPortfolioView()
                .environmentObject(vm)
        })
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    isAddPortfolioViewVisible.toggle()
                }) {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

#Preview {
    NavigationView{
        PortfolioView()
    }
    .environmentObject(HomeViewModel())
}
