//
//  RequestURL.swift
//
//

import Foundation
import SwiftUI

struct RequestURL {
    
    static func postUrl(url:String) -> String? {
        return baseURL + url
    }
    
    static func userUrl(url:String) -> String? {
        return baseURL + url
    }
    
}
