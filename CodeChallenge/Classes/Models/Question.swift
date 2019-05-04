//
//  Question.swift
//  CodeChallenge
//
//  Created by Sebastien Audeon on 5/4/19.
//  Copyright © 2019 LuckyDay. All rights reserved.
//

import UIKit

enum QuestionDifficulty: String {
    case easy = "easy"
    case medium = "medium"
    case hard = "hard"
}

class Question: NSObject {
    
    var question: String?
    var category: String?
    var difficulty: QuestionDifficulty = .easy
    
    var answer: String?
    var type: String?

    override init() {
        super.init()
    }
    
    internal init(with json: GenericDictionary) {
        
        self.question = json["question"] as? String
        self.category = json["category"] as? String
        
        if let difficulty = json["difficult"] as? String {
            self.difficulty = QuestionDifficulty(rawValue: difficulty) ?? .easy
        }
        
        self.answer = json["correct_answer"] as? String
        self.type = json["type"] as? String
        
    }
    
}

class Questions {
    var questions = Array<Question>()
    
    required public init(with json: [GenericDictionary]) {
        for question:GenericDictionary in json {
            questions.append(Question(with: question))
        }
    }
}
