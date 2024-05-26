//
//  ResourceBuilder.swift
//  TalkShopDemo
//
//  Created by Ritesh Vishwakarma on 26/05/24.
//

import Foundation
import Combine

struct ResourceBuilder {
    
    static func getPostAPIResource(url: String) -> AnyPublisher<PostModel, Error> {
        let url = URL(string: RequestURL.postURL(url: url))!
        return URLSession.shared.dataTaskPublisher(for: url)
            .map{ $0.data}
            .decode(type: PostModel.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    static func getUserAPIResource(url: String) -> AnyPublisher<UserModel, Error> {
        let url = URL(string: RequestURL.userURL(url: url))!
        return URLSession.shared.dataTaskPublisher(for: url)
            .map{ $0.data}
            .decode(type: UserModel.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
