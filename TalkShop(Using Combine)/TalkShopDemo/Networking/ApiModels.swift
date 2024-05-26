//
//  ApiModels.swift
//  TalkShopDemo
//
//  Created by Ritesh Vishwakarma on 26/05/24.
//

import Foundation

struct PostModelElement: Codable {
    let postID: String
    let videoURL: String
    let thumbnailURL: String
    let username: String
    let likes: Int
    var id: String

    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case videoURL = "videoUrl"
        case thumbnailURL = "thumbnail_url"
        case username, likes, id
    }
}

typealias PostModel = [PostModelElement]


// MARK: - User Model
struct UserModel: Codable {
    let username: String
    let profilePictureURL: String
    let posts: [Post]

    enum CodingKeys: String, CodingKey {
        case username
        case profilePictureURL = "profilePictureUrl"
        case posts
    }
}

// MARK: - Post
struct Post: Codable, Identifiable {
    var id: String { postID }
    let postID: String
    let videoURL: String
    let thumbnailURL: String
    let likes: Int

    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case videoURL = "videoUrl"
        case thumbnailURL = "thumbnail_url"
        case likes
    }
}
