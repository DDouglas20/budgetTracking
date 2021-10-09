//
//  Extensions.swift
//  BudgetTracker
//
//  Created by DeQuan Douglas on 8/29/21.
//

import Foundation
import UIKit


extension Notification.Name {
    static let didAddPurchase = Notification.Name("didAddPurchase")
    
    static let didDeletePurchase = Notification.Name("didDeletePurchase")
}

extension UIView {
    /// Adding multiple subviews at once
    func addSubviews(_ views: UIView...) { // Variatic Parameter (pass in multiple UIViews)
        views.forEach {
            addSubview($0)
        }
    }
}

//MARK: Number Formatter
extension NumberFormatter {
    static let percentFormatter: NumberFormatter = {
       let formatter = NumberFormatter()
        formatter.locale = .current
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 2
        return formatter
    }()
}

//MARK: String
extension String {
    static func percentage(from double: Double) -> String {
        let formatter = NumberFormatter.percentFormatter
        return formatter.string(from: NSNumber(value: double)) ?? "\(double)"
    }
}

// MARK: Framing

extension UIView {
    var width: CGFloat {
        frame.size.width
    }
    
    var height: CGFloat {
        frame.size.height
    }
    
    var left: CGFloat {
        frame.origin.x
    }
    
    var right: CGFloat {
        left + width
    }
    
    var top: CGFloat {
        frame.origin.y
    }
    
    var bottom: CGFloat {
        top + height
    }
    
}
