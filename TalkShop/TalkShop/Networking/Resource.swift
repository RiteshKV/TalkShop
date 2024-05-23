//
//  Resource.swift
//
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
    case patch = "PATCH"

}

struct Resource<A> {
    let url: String
    let api:String?
    let parent: AnyObject?
    let httpBody: Data?
    let method: HTTPMethod
    let parse: (Data) -> A?
}
