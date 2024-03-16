//
//  HomeView.swift
//  CryptoWatcher
//
//  Created by Homit Dalia on 16/03/24.
//

import SwiftUI

struct HomeView: View {
    
    @State private var showPortfolio : Bool = false
    
    var body: some View {
        ZStack{
            Color.theme.background
                .ignoresSafeArea()
            VStack{
                homeHeaderView
                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
            }
        }
    }
}

extension HomeView {
    
    private var homeHeaderView: some View {
        HStack{
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
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
}

#Preview {
    HomeView()
}
