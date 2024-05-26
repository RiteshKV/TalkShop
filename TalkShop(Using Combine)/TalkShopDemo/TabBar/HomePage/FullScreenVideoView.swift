//
//  FullScreenVideoView.swift
//  TalkShopDemo
//
//  Created by Ritesh Vishwakarma on 26/05/24.
//

import SwiftUI
import AVKit

struct FullScreenVideoView: View {
    @Environment(\.presentationMode) var presentationMode
    let post: PostModelElement
    @State private var player: AVPlayer? = nil

    var body: some View {
        ZStack(alignment: .topLeading) {
            if let url = URL(string: post.videoURL) {
                VideoPlayer(player: player)
                    .onAppear {
                        player = AVPlayer(url: url)
                        player?.play()
                    }
                    .onDisappear {
                        player?.pause()
                        player = nil
                    }
                    .edgesIgnoringSafeArea(.all)
            }

            VStack (alignment: .leading){
                HStack(spacing: 10) {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                        .foregroundColor(.white)
                    
                    Text(post.username)
                        .font(.headline)
                        .padding(.vertical, 5)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.white)
                    }
                }
                .padding([.leading, .trailing, .top], 16)
                .background(Color.black.opacity(0.6))
                .cornerRadius(10)
                
                HStack(spacing: 10) {
                    Image("heart")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 20, height: 20)
                        .foregroundColor(.white)
                    
                    Text("\(post.likes) likes")
                        .font(.footnote)
                        .padding(.vertical, 5)
                        .foregroundColor(.white)
                }
                .padding(.leading, 50)
                .cornerRadius(10)
                
                Spacer()
            }
        }
    }
}
