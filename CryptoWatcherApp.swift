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
            NavigationView {
                HomeView()
            }
            .environmentObject(vm)
            .toolbar(.hidden, for: .navigationBar)
        }
    }
}
