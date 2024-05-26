//
//  RequestURL.swift
//  TalkShopDemo
//
//  Created by Ritesh Vishwakarma on 26/05/24.
//

import Foundation

struct RequestURL {
    
    static let baseURL = "http://localhost:3000/"
    
    static func postURL(url: String) -> String {
        return baseURL + url
    }
    
    static func userURL(url: String) -> String {
        return baseURL + url
    }
}
