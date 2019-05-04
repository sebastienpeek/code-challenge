//
//  MainViewController.swift
//  CodeChallenge
//
//  Created by Sebastien Audeon on 5/4/19.
//  Copyright © 2019 LuckyDay. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerTitleLabel: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var resultsView: UIView!
    @IBOutlet weak var lastGameLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    var questions: [Question] = []
    var answeredCorrectly: [Question] = []
    
    var position: Int = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startButton.layer.cornerRadius = 3
        startButton.layer.borderWidth = 1
        startButton.layer.borderColor = UIColor.black.cgColor
        startButton.setTitleColor(.black, for: .normal)
        
        performAPIRequest()
    }
    
    func performAPIRequest() {
        
        let setupController: (() -> Void) = {
            
            if self.questions.count == 0 {
                self.resultsView.isHidden = false
            } else {
                let question = self.questions[self.position]
                self.setupController(with: question)
            }
            
        }
        
        QuestionManager().get(with: ["amount": 10, "type": "boolean"]) { (success, response) in
            if let parsedQuestions = response as? [Question], success {
                self.questions.append(contentsOf: parsedQuestions)
            }
            
            DispatchQueue.main.async {
                setupController()
            }
        }
        
    }

    func setupController(with question: Question) {
        guard let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "questionViewController") as? QuestionViewController else { return }
        
        self.addArrangedSubview(with: controller)
        
        controller.delegate = self
        controller.setupView(with: question, and: position + 1)
        
        position += 1
    }
    
    @IBAction func startGameAgain() {
        
        resultsView.isHidden = true
        
        self.children.forEach { controller in
            controller.view.removeFromSuperview()
            controller.removeFromParent()
        }
        
        position = 0
        questions.removeAll()
        answeredCorrectly.removeAll()
        
        performAPIRequest()
        
    }
    
}


extension MainViewController {
    
    func addArrangedSubview(with controller: UIViewController) {
 
        controller.view.width(constant: self.scrollView.frame.size.width)
        
        controller.willMove(toParent: self)
        addChild(controller)
        stackView.addArrangedSubview(controller.view)
        controller.didMove(toParent: self)
        
    }
    
}

extension MainViewController: QuestionDelegate {
    
    func answeredSuccessfully(for question: Question) {
        answeredCorrectly.append(question)
        
        let moveToNextQuestion: (() -> Void) = {
            let question = self.questions[self.position]
            self.setupController(with: question)
            
            let currentX = self.scrollView.contentOffset.x
            let newX = currentX + self.scrollView.frame.width
            
            self.scrollView.setContentOffset(CGPoint(x: newX, y: 0), animated: true)
            
        }
        
        if self.position == self.questions.count - 1 {
            
            QuestionManager().get(with: ["amount": 10, "type": "boolean"]) { (success, response) in
                if let parsedQuestions = response as? [Question], success {
                    self.questions.append(contentsOf: parsedQuestions)
                }
                
                DispatchQueue.main.async {
                    moveToNextQuestion()
                }
            }
            
        } else {
            moveToNextQuestion()
        }
        
    }
    
    func answeredIncorrectly() {
        
        var highestScore = UserDefaults.standard.integer(forKey: "highestScore")
        
        if highestScore < self.answeredCorrectly.count {
            UserDefaults.standard.set(self.answeredCorrectly.count, forKey: "highestScore")
            highestScore = self.answeredCorrectly.count
        }
        
        self.lastGameLabel.text = "Answered Correctly: \(self.answeredCorrectly.count)"
        self.highScoreLabel.text = "Highest Score: \(highestScore)"
        
        self.resultsView.isHidden = false
    }
    
}
