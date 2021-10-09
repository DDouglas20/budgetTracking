//
//  Alerts.swift
//  BudgetTracker
//
//  Created by DeQuan Douglas on 9/24/21.
//

import Foundation
import UIKit

extension UIViewController {
    
    public func noBudgetEntered() {
        let alert = UIAlertController(title: "No Budget Added",
                                      message: "Please Enter Your Budget for the Month",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss",
                                      style: .cancel,
                                      handler: nil))
        present(alert, animated: true)
    }
    
    public func deletePurchaseWarning(completion: @escaping (Bool) -> Void) {
        let alert = UIAlertController(title: "Warning",
                                      message: "Are You Sure You Want To Delete This Purchase?",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Delete",
                                      style: .destructive,
                                      handler: { _ in
                                        completion(true)
                                      }))
        alert.addAction(UIAlertAction(title: "Cancel",
                                      style: .cancel,
                                      handler: { _ in
                                        completion(false)
                                      }))
        present(alert, animated: true, completion: nil)
    }
}
