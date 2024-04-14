//
//  CurrenciesView.swift
//  CryptoWatcher
//
//  Created by Homit Dalia on 25/03/24.
//

import SwiftUI

struct CurrenciesView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @State private var showPortfolio : Bool = false
    @State private var searchText: String = ""
    
    @State private var selectedCoin: CoinModel? = nil
    @State private var showDetailScreen: Bool = false
    
    var body: some View {
        ZStack{
            if !vm.isCoinDataLoading && vm.allCoins.isEmpty && !vm.searchTextCurrencies.isEmpty {
                ContentUnavailableView.search
            }
            else {
                List {
                    Section() {
                        StatsView(type: .market, statistics: vm.marketStatistics)
                    }
                    .listRowSeparator(.hidden)
                    ForEach(vm.allCoins) { coin in
                        CoinRowView(coin: coin, showHoldingColumn: false)
                            .onTapGesture {
                                handleOnPressCoin(coin: coin)
                            }
                    }
                }
                .listStyle(.plain)
               
                .refreshable {
                    vm.refreshData()
                }
                .autocorrectionDisabled()
            }
        }
        .background(
            NavigationLink(isActive: $showDetailScreen, destination: {
                LazyDetailView(coin: $selectedCoin)
            }, label: {
                EmptyView()
            })
        )
        .searchable(text: $vm.searchTextCurrencies)
    }
    
    private func handleOnPressCoin(coin: CoinModel){
        selectedCoin = coin
        showDetailScreen.toggle()
    }
}

#Preview {
    NavigationView{
        CurrenciesView()
    }
    .environmentObject(HomeViewModel())
}

