//
//  QuestionManagerTests.swift
//  CodeChallengeTests
//
//  Created by Sebastien Audeon on 6/6/19.
//  Copyright © 2019 LuckyDay. All rights reserved.
//

import XCTest
@testable import CodeChallenge

class QuestionManagerTests: XCTestCase {

    func testFetchingOfQuestions() {
        let manager = QuestionManager.init()
        var questions: [Question] = []
        
        let expectation = self.expectation(description: "Successfully requested Questions")
        
        manager.get(with: ["amount": 10, "type": "boolean"]) { (success, response) in
            if let parsedQuestions = response as? [Question], success {
                questions.append(contentsOf: parsedQuestions)
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertTrue(questions.count == 10)
        
    }

}
