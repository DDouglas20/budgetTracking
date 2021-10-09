//
//  PreviousBudgetScreenViewController.swift
//  BudgetTracker
//
//  Created by DeQuan Douglas on 9/26/21.
//

import UIKit

class PreviousBudgetScreenViewController: UIViewController {
    
    //MARK: Properties
    private let previousTotalSpendingArray = PreviousMonths().totalSpendingArray
    
    
    
    private var month: String

    
    //MARK: Lifecycle
    init(month: String) {
        self.month = month
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    //MARK: Functions

}
