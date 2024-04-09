//
//  AddPortfolioView.swift
//  CryptoWatcher
//
//  Created by Homit Dalia on 03/04/24.
//

import SwiftUI

struct AddPortfolioView: View {
    
    @EnvironmentObject var vm: HomeViewModel
    @State var selectedCoin: CoinModel? = nil
    @State var currentAmount: String = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(vm.allCoins) { coin in
                            CoinPortfolioView(coin: coin)
                                .frame(width: 60)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(selectedCoin?.id == coin.id ? Color.theme.accent : Color.clear, lineWidth: 2)
                                )
                                .cornerRadius(8)
                                .onTapGesture {
                                    withAnimation(.spring) {
                                        handleOnPressCoin(coin: coin)
                                    }
                                }
                        }
                    }
                    .searchable(text: $vm.searchTextCurrencies)
                    
                }
                .padding(.bottom, 20)
                
                if selectedCoin != nil {
                    VStack (spacing: 20){
                        HStack{
                            Text("Current Price of \(selectedCoin?.symbol.uppercased() ?? "")")
                            Spacer()
                            Text(selectedCoin?.currentPrice.asCurrencyWith2Decimals() ?? "")
                        }
                        Divider()
                        HStack{
                            Text("Amount")
                            Spacer()
                            TextField("Ex. 1.4", text: $currentAmount)
                                .multilineTextAlignment(.trailing)
                                .keyboardType(.decimalPad)
                        }
                        Divider()
                        HStack{
                            Text("Current Value")
                            Spacer()
                            Text(getCurrentValue().asCurrencyWith2Decimals())
                                .foregroundStyle(getCurrentValue() > 0.00 ? Color.theme.accent : Color.theme.secondaryText) 
                        }
                    }
                }
            }
            .padding()
            .navigationTitle("Add Portfolio")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Image(systemName: "xmark")
                        .foregroundStyle(Color.theme.secondaryText)
                }
                
                if !currentAmount.isEmpty {
                    withAnimation(.spring) {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button(action: {
                                handleOnPressSave()
                            }, label: {
                                Text("Save".uppercased())
                                    .fontWeight(.bold)
                                    .foregroundStyle(Color.theme.accent)
                            })
                        }
                    }
                }
            }
        }
    }
    
    private func handleOnPressCoin(coin: CoinModel) {
        selectedCoin = coin
        
        if let amount = vm.allPortfolio.first(where: {$0.id == coin.id})?.currentHoldings {
            currentAmount = String(amount)
        } else {
            currentAmount = ""
        }
    }
    
    private func handleOnPressSave() {
        guard let coin = selectedCoin, !currentAmount.isEmpty else {return}
        
        if let amount = Double(currentAmount) {
            vm.updatePortfolio(coin: coin, amount: amount)
        } else {
            // Handle invalid amount input, such as non-numeric characters
            print("Invalid amount input")
        }
        
        selectedCoin = nil
        currentAmount = ""
    }

    
    private func getCurrentValue() -> Double {
        if let quantity = Double(currentAmount) {
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }
}

#Preview {
    AddPortfolioView()
        .environmentObject(HomeViewModel())
}
