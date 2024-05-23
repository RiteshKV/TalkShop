import SwiftUI
import AVKit

struct FeedView: View {
    @ObservedObject var viewmodel = viewModel()
    @Binding var selectedTab: Int
    @State private var isRefreshing = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.gray
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    LazyVStack(spacing: 0) {
                        if let posts = viewmodel.postModel {
                            ForEach(posts, id: \.id) { post in
                                VideoView(post: post, selectedTab: $selectedTab)
                                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.7)
                                    .environmentObject(viewmodel)
                            }
                        }
                    }
                }
            }
            .onAppear {
                viewmodel.getPostAPI()
            }
            .onDisappear {
                
            }
            .navigationTitle("Home")
        }
        .refreshable {
            await viewmodel.getPostAPI()
        }
    }
}
