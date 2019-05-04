//
//  QuestionRouter.swift
//  CodeChallenge
//
//  Created by Sebastien Audeon on 5/4/19.
//  Copyright © 2019 LuckyDay. All rights reserved.
//

import Alamofire

enum QuestionRouter: URLRequestConvertible {
    
    case get(GenericDictionary)
    
    var method: Alamofire.HTTPMethod {
        return .get
    }
    
    var path: String {
        switch self {
        case .get(_):
            return "/api.php"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        
        let url = try "https://opentdb.com".asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        
        urlRequest.timeoutInterval = 30
        
        switch self {
        case .get(let params):
            urlRequest = try URLEncoding.default.encode(urlRequest, with: params)
        }
        
        return urlRequest
        
    }
    
}
