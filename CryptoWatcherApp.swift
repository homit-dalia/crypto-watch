//
//  CryptoWatcherApp.swift
//  CryptoWatcher
//
//  Created by Homit Dalia on 15/03/24.
//

import SwiftUI

@main
struct CryptoWatcherApp: App {
    
    @StateObject var vm = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            TabView(selection: $vm.selectedTab) {
                // Tab 1
                tabContentView(for: .currencies)
                    .tabItem {
                        Image(systemName: "centsign.circle")
                        Text(Tab.currencies.title)
                    }
                    .tag(0)
                
                tabContentView(for: .portfolio)
                    .tabItem {
                        Image(systemName: "bag.circle")
                        Text(Tab.portfolio.title)
                    }
                    .tag(1)
                
            }
            .accentColor(Color.theme.accent)
        }
    }
    
    // Function to create content view for each tab
    private func tabContentView(for tab: Tab) -> some View {
        NavigationView {
            if tab == .currencies {
                CurrenciesView()
                    .navigationTitle(tab.title)
            }
            else if tab == .portfolio {
                PortfolioView()
                    .navigationTitle(tab.title)
            }
        }
        .environmentObject(vm)
    }
}

enum Tab {
    case currencies, portfolio
    
    var title: String {
        switch self {
            case .currencies: return "Currencies"
            case .portfolio: return "Portfolio"
        }
    }
}
