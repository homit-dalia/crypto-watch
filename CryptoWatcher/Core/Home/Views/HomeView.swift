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
    @State private var searchText: String = ""
    
    var body: some View {
        ZStack{
            List {
                ForEach(vm.allCoins) { coin in
                    CoinRowView(coin: coin, showHoldingColumn: false)
                }
            }
            .listStyle(.plain)
            .searchable(text: $searchText)
            .autocorrectionDisabled()
        }
    }
}

//extension HomeView {
//
//    private var homeHeaderView: some View {
//        HStack{
//            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
//                .animation(.none)
//            Spacer()
//            Text(showPortfolio ? "Portfolio" : "Market")
//                .animation(.none)
//                .font(.title2)
//                .fontWeight(.heavy)
//            Spacer()
//            CircleButtonView(iconName: showPortfolio ? "chevron.left" : "chevron.right")
//                .onTapGesture {
//                    withAnimation(.spring()){
//                        showPortfolio.toggle()
//                    }
//                }
//        }
//        .padding(.horizontal)
//    }
//
//    private var listHeader: some View {
//        HStack {
//            if showPortfolio {
//                listHeaderItem(title: "Coin")
//                Spacer()
//                listHeaderItem(title: "Holdings")
//                Spacer()
//                listHeaderItem(title: "Price")
//            }
//            else {
//                listHeaderItem(title: "Coin")
//                Spacer()
//                listHeaderItem(title: "Price")
//            }
//        }
//        .padding(.horizontal, 20)
//    }
//
//    private func listHeaderItem(title: String) -> some View {
//        Text(title)
//            .font(.callout)
//            .fontWeight(.semibold)
//    }
//}

#Preview {
    NavigationView{
        HomeView()
    }
    .environmentObject(HomeViewModel())
}
