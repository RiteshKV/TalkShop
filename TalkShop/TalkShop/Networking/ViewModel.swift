//
//  ViewModel.swift
//
//

import Foundation
import SwiftUI
import Combine

class ViewModel : ObservableObject {
    
    class func getPostAPI(parent:AnyObject?,url:String?,httpBody:Data?,complition: @escaping (PostModel?, String) ->()) {
            
        let resource: Resource<PostModel?>?
        resource = ResourceBuilder.getPostAPIResources(parent: parent,url:url, httpBody: httpBody)
        Webservice.load(resource: resource) { result,errstr  in
            switch result {
            case .failure( _):
                complition(nil,errstr)
            case .success(let result):
                complition(result,errstr)
            }
        }
    }
    
    class func getUserAPI(parent:AnyObject?,url:String?,httpBody:Data?,complition: @escaping (UserModel?, String) ->()) {
            
        let resource: Resource<UserModel?>?
        resource = ResourceBuilder.getUserAPIResources(parent: parent,url:url, httpBody: httpBody)
        Webservice.load(resource: resource) { result,errstr  in
            switch result {
            case .failure( _):
                complition(nil,errstr)
            case .success(let result):
                complition(result,errstr)
            }
        }
    }
}
