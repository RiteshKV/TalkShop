//
//  ResourceBuilder.swift
//
//

import Foundation
import SwiftUI

struct ResourceBuilder {
    
    static func getPostAPIResources(parent:AnyObject?,url:String?,httpBody:Data?) -> Resource<PostModel?>? {
        
        let strUrl = RequestURL.postUrl(url: url!)
        print("Summary == \(strUrl ?? "----")")

        return Resource(url: strUrl!, api: "", parent: parent, httpBody: httpBody, method: .get) { (dataValue) in
            do {
                let modal = try JSONDecoder()
                    .decode(PostModel.self, from: dataValue)
                return modal
            } catch {
                print(error)
                return nil
            }
        }
    }
    
    static func getUserAPIResources(parent:AnyObject?,url:String?,httpBody:Data?) -> Resource<UserModel?>? {
        
        let strUrl = RequestURL.userUrl(url: url!)
        print("Summary == \(strUrl ?? "----")")

        return Resource(url: strUrl!, api: "", parent: parent, httpBody: httpBody, method: .get) { (dataValue) in
            do {
                let modal = try JSONDecoder()
                    .decode(UserModel.self, from: dataValue)
                return modal
            } catch {
                print(error)
                return nil
            }
        }
    }
}
