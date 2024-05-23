import SwiftUI
import AVKit

struct VideoPreviewView: View {
    let post: Post
    @Binding var player: AVPlayer?
    
    var body: some View {
        VStack {
            if let url = URL(string: post.videoURL) {
                VideoPlayer(player: player)
                    .aspectRatio(contentMode: .fill)
                    .onAppear {
                        player = AVPlayer(url: url)
                        player?.play()
                    }
                    .onDisappear {
                        player?.pause()
                    }
            } else {
                Color.black
            }
        }
        .frame(width: UIScreen.main.bounds.width / 2 - 24, height: UIScreen.main.bounds.width / 2 - 24)
        .background(Color.black)
    }
}
