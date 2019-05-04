//
//  QuestionManager.swift
//  CodeChallenge
//
//  Created by Sebastien Audeon on 5/4/19.
//  Copyright © 2019 LuckyDay. All rights reserved.
//

import Foundation
import Alamofire

class QuestionManager {

    init() {
        
    }
    
    func get(with params: GenericDictionary, completion: @escaping ApiManagerCompletionHandler) {
        
        let request = QuestionRouter.get(params)
        OTApiManager.handleRequest(with: request) { (success, response) in
            if (success) {
                if let json = response as? GenericDictionary {
                    guard let results = json["results"] as? [GenericDictionary] else {
                        completion(false, response)
                        return
                    }
                    
                    let questions = Questions(with: results).questions
                    completion(success, questions)
                }
            } else {
                completion(false, "Error")
            }
        }
        
    }
    
}
