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
    
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var falseButton: UIButton!
    
    var question: Question!
    var delegate: QuestionDelegate!
    
    var position: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        trueButton.layer.cornerRadius = 3
        trueButton.layer.borderWidth = 1
        trueButton.layer.borderColor = UIColor.green.cgColor
        trueButton.setTitleColor(.green, for: .normal)
        
        falseButton.layer.cornerRadius = 3
        falseButton.layer.borderWidth = 1
        falseButton.layer.borderColor = UIColor.red.cgColor
        falseButton.setTitleColor(.red, for: .normal)
        
    }
    
    func setupView(with question: Question, and position: Int) {
        
        self.question = question
        questionLabel.text = question.question ?? "Empty Question"
        questionPositionLabel.text = "Question \(position)"
        
    }
    
    @IBAction func trueSelected() {
        trueButton.isEnabled = false
        falseButton.isEnabled = false
        
        trueButton.isSelected = true
        trueButton.setBackgroundColor(.green)
        
        question.apply("True")
        
        if question.answeredCorrectly {
            delegate.answeredSuccessfully(for: question)
        } else {
            shakeView()
            delegate.answeredIncorrectly()
        }
        
    }
    
    @IBAction func falseSelected() {
        trueButton.isEnabled = false
        falseButton.isEnabled = false
        
        falseButton.isSelected = true
        falseButton.setBackgroundColor(.red)
        
        question.apply("False")
        
        if question.answeredCorrectly {
            delegate.answeredSuccessfully(for: question)
        } else {
            shakeView()
            delegate.answeredIncorrectly()
        }
        
    }
    
}

extension QuestionViewController {
    
    func shakeView() {
        
        let midX = backgroundView.center.x
        let midY = backgroundView.center.y
        
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.06
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = CGPoint(x: midX - 10, y: midY)
        animation.toValue = CGPoint(x: midX + 10, y: midY)
        backgroundView.layer.add(animation, forKey: "position")
        
    }
    
}
