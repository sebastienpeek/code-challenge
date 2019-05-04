//
//  QuestionViewController.swift
//  CodeChallenge
//
//  Created by Sebastien Audeon on 5/4/19.
//  Copyright © 2019 LuckyDay. All rights reserved.
//

import UIKit

protocol QuestionDelegate {
    func answeredSuccessfully(for question: Question)
    func answeredIncorrectly()
}

class QuestionViewController: UIViewController {
    
    @IBOutlet weak var questionPositionLabel: UILabel!
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var questionLabel: UILabel!
    
    var question: Question!
    var delegate: QuestionDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func setupView(with question: Question) {
        
        self.question = question
        questionLabel.text = question.question ?? "Empty Question"
        
    }
    
    @IBAction func trueSelected() {
        if question.answer == "True" {
            delegate.answeredSuccessfully(for: question)
        } else {
            delegate.answeredIncorrectly()
        }
    }
    
    @IBAction func falseSelected() {
        if question.answer == "False" {
            delegate.answeredSuccessfully(for: question)
        } else {
            delegate.answeredIncorrectly()
        }
    }
    
}
