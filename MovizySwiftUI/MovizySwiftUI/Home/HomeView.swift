//
//  HomeView.swift
//  MovizySwiftUI
//
//  Created by Deda on 20.05.20.
//  Copyright © 2020 Deda. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabBarView()
    }
}

extension TabBarView {
    enum Tabs: Int {
        case movies
        case discover
    }
}

struct TabBarView: View {
    @State private var selectedTab = Tabs.movies
    
    var body: some View {
        TabView(selection: $selectedTab) {
            MoviesHomeView()
                .tabItem { Text("Movies") }
                .tag(Tabs.movies)
            
            DiscoverHomeView()
                .tabItem { Text("Discover") }
                .tag(Tabs.discover)
        }
    }
}
