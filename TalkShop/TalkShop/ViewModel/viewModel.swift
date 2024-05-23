import Foundation
import Combine
import SwiftUI
import Network
import AVKit

class viewModel: ObservableObject {
    
    //MARK: Post api declaration
    @Published var postModel: PostModel?
    @Published var ispostLoding = false
    @Published var currentlyPlayingPostID: String?
    private var visibilityRects: [String: CGRect] = [:]

    func getPostAPI() {
        let jsonDic: NSDictionary = [:]
        var jsonData: Data? = nil
        do {
            jsonData = try JSONSerialization.data(withJSONObject: jsonDic, options: .prettyPrinted)
        } catch {
            
        }
        let parameters = String(data: jsonData!, encoding: .utf8)
        let postData = parameters!.data(using: .utf8)
        let externalAPIURL = "post"
        
        ViewModel.getPostAPI(parent: self, url: externalAPIURL, httpBody: postData) { (data, code) in
            if data != nil {
                if(code == "200") {
                    DispatchQueue.main.async {
                        self.postModel = data
                        self.ispostLoding = false
                    }
                } else {
                    DispatchQueue.main.async {
                        self.ispostLoding = false
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.ispostLoding = false
                }
            }
        }
    }
    
    func updateVisibility(for postId: String, rect: CGRect, screenHeight: CGFloat) {
        let intersectionHeight = rect.intersection(CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: screenHeight)).height
        visibilityRects[postId] = CGRect(x: rect.origin.x, y: rect.origin.y, width: rect.width, height: intersectionHeight)
        updateCurrentlyPlayingPost()
    }
    
    private func updateCurrentlyPlayingPost() {
        guard let maxVisiblePostID = visibilityRects.max(by: { $0.value.height < $1.value.height })?.key else { return }
        if currentlyPlayingPostID != maxVisiblePostID {
            currentlyPlayingPostID = maxVisiblePostID
        }
    }
    
    
    //MARK: Fetch user api declaration
    
    @Published var userModel: UserModel?
    @Published var isuserLoding = false

    func getUserAPI() {
        let jsonDic: NSDictionary = [:]
        var jsonData: Data? = nil
        do {
            jsonData = try JSONSerialization.data(withJSONObject: jsonDic, options: .prettyPrinted)
        } catch {
            
        }
        let parameters = String(data: jsonData!, encoding: .utf8)
        let postData = parameters!.data(using: .utf8)
        let externalAPIURL = "user"
        
        ViewModel.getUserAPI(parent: self, url: externalAPIURL, httpBody: postData) { (data, code) in
            if data != nil {
                if(code == "200") {
                    DispatchQueue.main.async {
                        self.userModel = data
                        self.isuserLoding = false
                    }
                } else {
                    DispatchQueue.main.async {
                        self.isuserLoding = false
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.isuserLoding = false
                }
            }
        }
    }
}
