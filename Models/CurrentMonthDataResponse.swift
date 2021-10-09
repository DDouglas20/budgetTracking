//
//  CurrentMonthDataResponse.swift
//  BudgetTracker
//
//  Created by DeQuan Douglas on 9/27/21.
//

import Foundation
import CoreData

struct currentMonthResponse {
    let totalBudgetArray: [Double]
    let purchasesArray: [Double]
    let budget: Int16
}
