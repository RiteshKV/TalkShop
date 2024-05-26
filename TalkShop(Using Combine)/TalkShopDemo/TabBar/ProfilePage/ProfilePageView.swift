//
//  ProfilePageView.swift
//  TalkShopDemo
//
//  Created by Ritesh Vishwakarma on 26/05/24.
//

import SwiftUI
import AVKit

struct ProfilePageView: View {
    @ObservedObject var viewmodel = ViewModel()
    @State private var selectedPost: Post?
    @State private var player: AVPlayer?

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    if let userProfile = viewmodel.user {
                        // Profile Information
                        HStack {
                            if let url = URL(string: userProfile.profilePictureURL) {
                                AsyncImage(url: url) { image in
                                    image.resizable()
                                } placeholder: {
                                    Color.gray
                                }
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                            }
                            VStack(alignment: .leading) {
                                Text(userProfile.username)
                                    .font(.title)
                                    .bold()
                                // Additional profile info can be added here
                            }
                            .padding(.leading, 16)
                        }
                        .padding(.leading, 16)

                        // User Posts
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                            ForEach(userProfile.posts) { post in
                                VStack {
                                    if selectedPost?.id == post.id, let player = player {
                                        VideoPlayer(player: player)
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: UIScreen.main.bounds.width / 2 - 24, height: UIScreen.main.bounds.width / 2 - 24)
                                            .onAppear {
                                                player.play()
                                            }
                                    } else {
                                        if let url = URL(string: post.thumbnailURL) {
                                            AsyncImage(url: url) { image in
                                                image.resizable()
                                            } placeholder: {
                                                Color.gray
                                            }
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: UIScreen.main.bounds.width / 2 - 24, height: UIScreen.main.bounds.width / 2 - 24)
                                            .clipped()
                                        }
                                    }
                                    Text("\(post.likes) likes")
                                        .font(.caption)
                                }
                                .contextMenu {
                                    Button(action: {
                                    }) {
                                        Text("Share Video")
                                        Image("share")
                                    }
                                }preview: {
                                    VideoPreviewView(post: post, player: $player)
                                 }
                                .background(Color.white)
                                .cornerRadius(8)
                                .shadow(radius: 5)
                            }
                        }
                        .padding()
                    } else {
                        ProgressView()
                            .onAppear {
                                viewmodel.fetchUser(url: "user")
                            }
                    }
                }
            }
            .navigationTitle("Profile")
        }
    }
}

#Preview {
    ProfilePageView()
}
