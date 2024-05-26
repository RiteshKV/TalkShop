//
//  FeedView.swift
//  TalkShopDemo
//
//  Created by Ritesh Vishwakarma on 26/05/24.
//

import SwiftUI
import AVKit

struct FeedView: View {
    @ObservedObject var viewmodel = ViewModel()
    @Binding var selectedTab: Int
    @State private var isRefreshing = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.gray
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(viewmodel.posts, id: \.id) { post in
                            VideoView(post: post, selectedTab: $selectedTab)
                                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.7)
                                .environmentObject(viewmodel)
                        }
                    }
                }
            }
            .onAppear {
                viewmodel.fetchPosts(url: "post")
            }
            .onDisappear {
                
            }
            .navigationTitle("Home")
        }
        .refreshable {
            await viewmodel.fetchPosts(url: "post")
        }
    }
}
