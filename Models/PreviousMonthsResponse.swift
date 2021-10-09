//
//  Models.swift
//  BudgetTracker
//
//  Created by DeQuan Douglas on 9/2/21.
//

import Foundation
import CoreData

struct previousMonthsResponse {
    let totalSpendingArray: Double
    let purchasesArray: [Double]
    let month: String
    
}

/* Fetching Core Data
 
    let fetchRequest: NSFetchRequest<PreviousMonths> = PrevousMonths.fetchRequest()
 
    do {
        let previousMonths = try PersistenceManager.context.fetch(fetchRequest)
        PersistenceManager.shared.previousMonths = previousMonths
    } catch {fatalError()}
 
 
 */
