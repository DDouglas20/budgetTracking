//
//  BreakdownViewController.swift
//  BudgetTracker
//
//  Created by DeQuan Douglas on 9/3/21.
//

import UIKit

class BreakdownViewController: UIViewController {
    
    //MARK: Properties
    let budget = PersistenceManager.shared.totalBudgetArray[0]
    var price = Double()
    var row = Int()
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28)
        label.contentMode = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 48)
        label.textAlignment = .center
        return label
    }()
    
    var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.contentMode = .center
        return label
    }()
    
    var percentageSpentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.contentMode = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    let deletePurchaseButton: UIButton = {
        let button = UIButton()
        button.setTitle("Delete Purchase", for: .normal)
        button.layer.cornerRadius = 6
        button.layer.borderWidth = 2
        button.backgroundColor = .systemRed
        
        return button
    }()
    
    
    
    
    //MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        view.addSubviews(descriptionLabel, priceLabel, dateLabel, percentageSpentLabel, deletePurchaseButton)
        createPercentageLabel()
        deletePurchaseButton.addTarget(self, action: #selector(deletePurchase), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        descriptionLabel.sizeToFit()
        descriptionLabel.frame =
            CGRect(
                x: 5,
                y: view.height / 6,
                width: view.width - 10,
                height: 80
            )
        priceLabel.sizeToFit()
        priceLabel.frame = CGRect(x: view.center.x - (priceLabel.width/2),
                                  y: descriptionLabel.bottom + 10,
                                  width: priceLabel.width,
                                  height: priceLabel.height)
        dateLabel.sizeToFit()
        dateLabel.frame = CGRect(x: view.center.x - (dateLabel.width/2),
                                 y: priceLabel.bottom + 10,
                                 width: dateLabel.width,
                                 height: dateLabel.height)
        percentageSpentLabel.sizeToFit()
        percentageSpentLabel.frame = CGRect(x: 5,
                                            y: dateLabel.bottom + 30,
                                            width: view.width - 10,
                                            height: 40)
        deletePurchaseButton.frame = CGRect(x: (view.center.x/2),
                                            y: percentageSpentLabel.bottom + 5,
                                            width: view.width/2,
                                            height: 50)
    }
    
    init(date: String, price: String, descriptionText: String, row: Int) {
        
        self.price = Double(price.replacingOccurrences(of: "$", with: ""))!
        self.row = row
        descriptionLabel.text = descriptionText
        priceLabel.text = price
        dateLabel.text = date
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //MARK: Functions
    private func createPercentageLabel() {
        let percentage = price / PersistenceManager.monthsBudget
        print("This is price: \(price) \n This monthsBudget: \(PersistenceManager.monthsBudget) \n This is percentage: \(percentage)")
        percentageSpentLabel.text = "This is the total percent of your budget that you spent on this item: \(String.percentage(from: percentage))"
    }
    
    @objc private func deletePurchase() {
        deletePurchaseWarning(completion: { [weak self] bool in
            if bool == true {
                PersistenceManager.shared.deletePurchase(row: self!.row)
                NotificationCenter.default.post(name: .didDeletePurchase, object: nil)
                self?.navigationController?.popViewController(animated: true)
            }
            else {
                return 
            }
        })
    }

}
