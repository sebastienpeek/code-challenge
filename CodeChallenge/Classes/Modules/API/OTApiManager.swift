//
//  OTApiManager.swift
//  CodeChallenge
//
//  Created by Sebastien Audeon on 5/4/19.
//  Copyright © 2019 LuckyDay. All rights reserved.
//

import Foundation
import Alamofire

typealias GenericDictionary = [String: Any]
typealias ApiManagerCompletionHandler = (Bool, Any) -> Void

class OTApiManager {

    static let instance: OTApiManager = OTApiManager()
    
    internal static var manager: Alamofire.SessionManager = {
        
        let sessionManager = Alamofire.SessionManager(configuration: URLSessionConfiguration.default)
        return sessionManager
        
    }()
    
}

extension OTApiManager {
    
    class func handleRequest(with request: URLRequestConvertible, completion: @escaping ApiManagerCompletionHandler) {

        let dispatchQueue = DispatchQueue(label: "apiLayerQueue", qos: .background, attributes: .concurrent)
        
        self.manager.request(request)
        .validate()
            .responseJSON(queue: dispatchQueue) { response in
                
                switch response.result {
                case .success(let json):
                    completion(true, json)
                case .failure(let error):
                    completion(false, error)
                }
                
        }
        
    }
    
}
