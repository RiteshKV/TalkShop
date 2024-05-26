//
//  ViewModel.swift
//  TalkShopDemo
//
//  Created by Ritesh Vishwakarma on 26/05/24.
//

import Foundation
import Combine
import UIKit

class ViewModel: ObservableObject {
    @Published var posts : PostModel = []
    @Published var user: UserModel?
    @Published var errorMessage : String?
    
    @Published var currentlyPlayingPostID: String?
    private var visibilityRects: [String: CGRect] = [:]
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchPosts(url: String) {
        ResourceBuilder.getPostAPIResource(url: url)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { posts in
                self.posts = posts
                print(self.posts)
            })
            .store(in: &cancellables)
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
    
    func fetchUser(url: String) {
        ResourceBuilder.getUserAPIResource(url: url)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error)  = completion {
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { user in
                self.user = user
                print(self.user)
            })
            .store(in: &cancellables)
    }
}
