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
    
    var body: some View {
        HStack {
            List {
                Section() {
                    StatsView(type: .user)
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
        .toolbar {            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
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
