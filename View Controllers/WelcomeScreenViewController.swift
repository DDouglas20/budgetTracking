//
//  WelcomeScreenViewController.swift
//  BudgetTracker
//
//  Created by DeQuan Douglas on 9/17/21.
//

import UIKit
import CoreData

class WelcomeScreenViewController: UIViewController {
    //MARK: Properties
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 48)
        label.text = "Welcome!"
        label.textAlignment = .center
        return label
    }()
    
    private let instructionsLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 32)
        label.text = "Please Input Your Budget for the Month \n (You can adjust this as you need)"
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let budgetTextField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .decimalPad
        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont(name: "systemFont", size: 17)
        ]
        
        // ***** Create a $ label and place it on top of the text field ******* //
        // This will allow me to use leftViewMode to move the user input text back
        textField.attributedPlaceholder = NSAttributedString(string: "$", attributes: attributes)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        textField.leftViewMode = .always
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 6
        return textField
    }()
    
    private let startButton: UIButton = {
        let button = UIButton()
        button.setTitle("Start", for: .normal)
        button.backgroundColor = .systemGreen
        return button
    }()

    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubviews(welcomeLabel,instructionsLabel, budgetTextField, startButton)
        startButton.addTarget(self, action: #selector(startBudget), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        welcomeLabel.frame = CGRect(x: view.center.x - (view.width / 3),
                                    y: view.height / 10,
                                    width: view.width / 1.5,
                                    height: view.height / 10)
        
        instructionsLabel.frame = CGRect(x: 5,
                                         y: welcomeLabel.bottom + 10,
                                         width: view.width - 10,
                                         height: view.width / 4)
        
        budgetTextField.sizeToFit()
        budgetTextField.frame =  CGRect(x: view.width / 2 - (view.width / 4),
                                        y: instructionsLabel.bottom + 5,
                                        width: view.width / 2,
                                        height: 30)
        
        startButton.sizeToFit()
        startButton.frame = CGRect(x: budgetTextField.center.x - (budgetTextField.width / 4),
                                   y: budgetTextField.bottom + 5,
                                   width: budgetTextField.width / 2,
                                   height: startButton.height)
        
    }
    
    //MARK: Functions
    
    @objc func startBudget() {
        guard let budget = budgetTextField.text,
              !budget.isEmpty else {
                noBudgetEntered()
                return
        }

        UserDefaults.standard.setValue(false, forKey: "newUser")
        PersistenceManager.shared.totalBudgetArray[0] = Double(budget)!
        PersistenceManager.shared.newUser = false
        PersistenceManager.shared.createCoreDataObject()
        self.dismiss(animated: true, completion: nil)
    }


}
