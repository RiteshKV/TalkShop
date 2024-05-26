//
//  TabBarPageView.swift
//  TalkShopDemo
//
//  Created by Ritesh Vishwakarma on 26/05/24.
//

import SwiftUI

struct TabBarPageView: View {
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            FeedView(selectedTab: $selectedTab)
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(0)
            
            PostPageView()
                .tabItem {
                    Label("Post", systemImage: "plus.app")
                }
                .tag(1)
            
            ProfilePageView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
                .tag(2)
        }
    }
}

#Preview {
    TabBarPageView()
}
