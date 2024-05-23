import SwiftUI

struct TabbarView: View {
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
    TabbarView()
}
