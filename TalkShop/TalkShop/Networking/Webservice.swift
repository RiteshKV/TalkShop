//
//  Webservice.swift
//
//

import Foundation
import SwiftUI
import SystemConfiguration
import CoreData
import MobileCoreServices


enum NetworkError: Error {
    case parseUrl
    case parseJson
    case parseData
    case emptyResource
}

enum Webservice {
    
    static var numberOfRequests = 0 {
        didSet {
            DispatchQueue.main.async {
//                UIApplication.shared.isNetworkActivityIndicatorVisible = numberOfRequests > 0
            }
        }
    }
    
    @discardableResult
    static func load<A>(resource: Resource<A>?, completion: @escaping (Result<A, Error>,String) -> Void) -> URLSessionTask? {
        
        var errorStr = "Something went wrong, please try later."
        guard let resource = resource else {
            completion(.failure(NetworkError.emptyResource), errorStr)
            return nil
        }
        
        guard let url = URL(string: resource.url) else {
            completion(.failure(NetworkError.parseUrl), errorStr)
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = resource.method.rawValue
        
        let access_Token = UserDefaults.standard.value(forKey: "Access_Tocken") as? String ?? ""
        
        if(access_Token != ""){
            request.addValue("Bearer" + " " + access_Token , forHTTPHeaderField: "Authorization")
        }
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = TimeInterval(ktimeoutIntervalForRequest)
        
        let session = URLSession(configuration: configuration)
        
        if (request.httpMethod! == "POST" || request.httpMethod! == "PATCH" || request.httpMethod! == "PUT") {
            
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            
            request.httpBody = resource.httpBody!
        }
        else if (request.httpMethod! == "GET"){
            
        }
        
        else if (request.httpMethod! == "DELETE"){
            
        }
        
        numberOfRequests += 1
        let task = session.dataTask(with: request) { data, response, error in
            
            numberOfRequests -= 1
            
            var decryptedResponseData = data
            if(data != nil){
                //MARK: Important message
                let strEncryptedResponse = String(data: decryptedResponseData!, encoding: .utf8)
                
                // Fallback or
                decryptedResponseData = strEncryptedResponse?.data(using: .utf8)
                
                let httpResponse = response as? HTTPURLResponse
                print(request.url ?? "")
                print(httpResponse?.statusCode ?? 00)
                if httpResponse?.statusCode == 401{
                    errorStr = "\(httpResponse?.statusCode ?? 0)"

                }else if httpResponse?.statusCode == 500{
                    errorStr = "\(httpResponse?.statusCode ?? 0)"
                }else if httpResponse?.statusCode == 204{
                    errorStr = "\(httpResponse?.statusCode ?? 0)"
                }else {
                    //errorStr = strEncryptedResponse ?? "Server Error: Response Code : \(httpResponse?.statusCode)"
                    errorStr = "\(httpResponse?.statusCode ?? 0)"
                }
                if errorStr.contains("DOCTYPE"){
                    errorStr = "Something went wrong, please try later."
                }
            }
            
            guard error == nil, let _ = decryptedResponseData else {
                completion(.failure(error!), errorStr)
                return
            }
            guard let result = resource.parse(decryptedResponseData!) else {
                completion(.failure(NetworkError.parseData), errorStr)
                return
            }
            completion(.success(result), errorStr)
        }
        
        task.resume()
        return task
    }
    
}



extension Data {
    mutating func append(_ string: String, using encoding: String.Encoding = .utf8) {
        if let data = string.data(using: encoding) {
            append(data)
        }
    }
}

