//
//  HomeView.swift
//  CryptoWatcher
//
//  Created by Homit Dalia on 16/03/24.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @State private var showPortfolio : Bool = false
    
    var body: some View {
        ZStack{
            Color.theme.background
                .ignoresSafeArea()
            VStack {
                homeHeaderView
                
                listHeader
                
                if !showPortfolio {
                    List {
                        ForEach(vm.allCoins) { coin in
                            CoinRowView(coin: coin, showHoldingColumn: false)
                        }
                    }
                    .listStyle(.plain)
                    .transition(.move(edge: .leading))
                }
                
                if showPortfolio {
                    List {
                        ForEach(vm.allPortfolio) { coin in
                            CoinRowView(coin: coin, showHoldingColumn: true)
                        }
                    }
                    .listStyle(.plain)
                    .transition(.move(edge: .trailing))
                }
                
                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
            }
        }
    }
}

extension HomeView {
    
    private var homeHeaderView: some View {
        HStack{
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .animation(.none)
            Spacer()
            Text(showPortfolio ? "Portfolio" : "Market")
                .animation(.none)
                .font(.title2)
                .fontWeight(.heavy)
            Spacer()
            CircleButtonView(iconName: showPortfolio ? "chevron.left" : "chevron.right")
                .onTapGesture {
                    withAnimation(.spring()){
                        showPortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
    
    private var listHeader: some View {
        HStack {
            if showPortfolio {
                listHeaderItem(title: "Coin")
                Spacer()
                listHeaderItem(title: "Holdings")
                Spacer()
                listHeaderItem(title: "Price")
            }
            else {
                listHeaderItem(title: "Coin")
                Spacer()
                listHeaderItem(title: "Price")
            }
        }
        .padding(.horizontal, 20)
    }
    
    private func listHeaderItem(title: String) -> some View {
        Text(title)
            .font(.callout)
            .fontWeight(.semibold)
    }
}

#Preview {
    HomeView()
        .environmentObject(HomeViewModel())
}
