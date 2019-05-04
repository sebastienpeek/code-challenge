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
    
    @IBOutlet weak var emptyState: UIView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    
    var questions: [Question] = []
    var answeredCorrectly: [Question] = []
    
    var position: Int = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let setupController: (() -> Void) = {
            
            if self.questions.count == 0 {
                // show empty state
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
        controller.setupView(with: question)
        
        position += 1
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
        
    }
    
}
