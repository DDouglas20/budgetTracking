//
//  ValueTransformers.swift
//  BudgetTracker
//
//  Created by DeQuan Douglas on 9/29/21.
//

import Foundation
import UIKit

// Subclass from NSSecureUnarchiveFromDataTransformer
@objc(PurchasesTableViewCellViewModelTransformer)
final class PurchasesTableViewCellViewModelTransformer: NSSecureUnarchiveFromDataTransformer {
    
    // Name the value transformer
    static let name = NSValueTransformerName(rawValue: String(describing: PurchasesTableViewCellViewModelTransformer.self))
    
    // Put viewmodel in allowed class list
    override static var allowedTopLevelClasses: [AnyClass] {
        return [PurchasesTableViewCell.self]
    }
    
    // Register the transformer
    public static func registerPurchasesTableViewCellViewModelTransformer() {
        let transformer = PurchasesTableViewCellViewModelTransformer()
        ValueTransformer.setValueTransformer(transformer, forName: name)
    }
}

// Create Transformer for array of doubles
/*@objc(DoubleArrayValueTransformer)
final class DoubleArrayValueTransformer: NSSecureUnarchiveFromDataTransformer {
    
    //Name the value transformer
    static let name = NSValueTransformerName(rawValue: String(describing: DoubleArrayValueTransformer.self))
    
    // Put double array in allowed class list
    override static var allowedTopLevelClasses: [AnyClass] {
        return [Double.self]
    }
}*/
