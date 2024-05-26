//
//  VideoView.swift
//  TalkShopDemo
//
//  Created by Ritesh Vishwakarma on 26/05/24.
//

import SwiftUI
import AVKit

struct VideoView: View {
    let post: PostModelElement
    @State private var player: AVPlayer? = nil
    @EnvironmentObject var viewmodel: ViewModel
    @Environment(\.scenePhase) private var scenePhase
    @State private var videoRect: CGRect = .zero
    @State private var showFullScreen = false
    @Binding var selectedTab: Int

    var body: some View {
        VStack {
            HStack(spacing: 5) {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                
                Text(post.username)
                    .font(.headline)
                    .padding()
                    .foregroundColor(.white)
                    .cornerRadius(8)
                
                Spacer()
            }
            .padding(.leading, 16)
            
            ZStack(alignment: .topLeading) {
                if let player = player {
                    VideoPlayer(player: player)
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height * 0.5)
                        .onAppear {
                            print("VideoView onAppear - Player should play")
                            if viewmodel.currentlyPlayingPostID == post.id {
                                player.play()
                            }
                        }
                        .onDisappear {
                            print("VideoView onDisappear - Player should pause and be nil")
                            player.pause()
                            viewmodel.currentlyPlayingPostID = ""
                            self.player = nil
                        }
                        .onChange(of: viewmodel.currentlyPlayingPostID) { newPostID in
                            if newPostID == post.id {
                                print("VideoView onChange currentlyPlayingPostID - Player should play")
                                player.play()
                            } else {
                                print("VideoView onChange currentlyPlayingPostID - Player should pause")
                                player.pause()
                            }
                        }
                } else {
                    Color.black
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height * 0.5)
                        .onAppear {
                            print("VideoView onAppear - Initializing player")
                            let player = AVPlayer(url: URL(string: post.videoURL)!)
                            self.player = player
                            if viewmodel.currentlyPlayingPostID == post.id {
                                player.play()
                            }
                        }
                }
            }
            VStack(alignment: .leading, spacing: 5) {
                HStack(spacing: 20) {
                    Image("heart")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 40, height: 40)
                        .foregroundColor(.black)

                    Image("share")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                }
                .padding(.top, 5)
                .padding(.leading, 16)
                
                HStack {
                    Text("\(post.likes) likes")
                        .font(.title3)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding(.leading, 16)
                    Spacer()
                }
                .padding(.top, 5)
                .padding(.bottom, 16)
            }
        }
        .onDisappear {
            print("VideoView onDisappear - Ensuring player is paused and nil")
            player?.pause()
            viewmodel.currentlyPlayingPostID = "" // To stop the player from playing
            player = nil
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .background {
                print("VideoView onChange scenePhase - App in background, player should pause and be nil")
                player?.pause()
                viewmodel.currentlyPlayingPostID = "" // To stop the player from playing
                player = nil
            }
        }
        .onChange(of: selectedTab) { newTab in
            if newTab != 0 {
                print("VideoView onChange selectedTab - Tab changed, player should pause and be nil")
                player?.pause()
                viewmodel.currentlyPlayingPostID = "" // To stop the player from playing
                player = nil
            }
        }
        .background(GeometryReader { geometry in
            Color.clear
                .onAppear {
                    videoRect = geometry.frame(in: .global)
                    viewmodel.updateVisibility(for: post.id, rect: videoRect, screenHeight: UIScreen.main.bounds.height)
                }
                .onChange(of: geometry.frame(in: .global)) { newRect in
                    videoRect = newRect
                    viewmodel.updateVisibility(for: post.id, rect: videoRect, screenHeight: UIScreen.main.bounds.height)
                }
        })
        .onTapGesture {
            viewmodel.currentlyPlayingPostID = post.id
            player?.pause()
            showFullScreen = true
        }
        .fullScreenCover(isPresented: $showFullScreen) {
            FullScreenVideoView(post: post)
        }
    }
}
