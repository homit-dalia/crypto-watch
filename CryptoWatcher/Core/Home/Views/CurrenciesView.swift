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
    
    var body: some View {
        ZStack{
            if vm.allCoins.isEmpty && !vm.searchTextCurrencies.isEmpty {
                ContentUnavailableView.search
            }
            List {
                ForEach(vm.allCoins) { coin in
                    CoinRowView(coin: coin, showHoldingColumn: false)
                }
            }
            .listStyle(.plain)
            .searchable(text: $vm.searchTextCurrencies)
            .autocorrectionDisabled()
        }
    }
}

#Preview {
    NavigationView{
        CurrenciesView()
    }
    .environmentObject(HomeViewModel())
}
