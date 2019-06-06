//
//  QuestionModelTests.swift
//  CodeChallengeTests
//
//  Created by Sebastien Audeon on 6/6/19.
//  Copyright © 2019 LuckyDay. All rights reserved.
//

import XCTest

@testable import CodeChallenge

class QuestionModelTests: XCTestCase {

    func testQuestionSuccessfulAnswer() {
        // Given
        let question = Question(with: ["question": "A flock of crows is known as a homicide.",
                                       "correct_answer":"False"])
        
        // When
        question.apply("False")
        
        // Then
        XCTAssertTrue(question.answeredCorrectly)
    }
    
    func testQuestionUnsuccessfulAnswer() {
        // Given
        let question = Question(with: ["question": "A flock of crows is known as a homicide.",
                                       "correct_answer":"False"])
        
        // When
        question.apply("True")
        
        // Then
        XCTAssertFalse(question.answeredCorrectly)
    }
    
}
