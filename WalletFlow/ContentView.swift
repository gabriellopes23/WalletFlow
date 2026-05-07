//
//  ContentView.swift
//  WalletFlow
//
//  Created by Gabriel Lopes on 04/05/26.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house") {
                HomeView()
            }
            
            Tab("Stats", systemImage: "chart.bar.xaxis") {
                StatsView()
            }
            
            Tab("Profile", systemImage: "person") {
                Text("Profile")
            }
        }
        .background(.red)
    }
}

#Preview {
    ContentView()
}
