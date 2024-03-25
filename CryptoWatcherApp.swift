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
            HomeView()
                .navigationBarTitle(tab.title) // Set dynamic navigation title
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
