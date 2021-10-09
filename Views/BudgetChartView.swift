//
//  PieChartView.swift
//  BudgetTracker
//
//  Created by DeQuan Douglas on 8/28/21.
//

import UIKit
import Charts

class BudgetChartView: UIView {

    //MARK: Properties
    
    struct ViewModel {
        let data: [Double]
        let color: UIColor
    }
    
    private let chartView: PieChartView = {
        let chart = PieChartView()
        chart.usePercentValuesEnabled = true
        chart.legend.enabled = true
        //chart.circleBox = CGRect(x: <#T##CGFloat#>, y: <#T##CGFloat#>, width: <#T##CGFloat#>, height: <#T##CGFloat#>)
        
        return chart
    }()
    
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        chartView.frame = bounds
    }
    
    func reset() {
        chartView.data = nil
    }
    
    func configure(with viewModel: ViewModel) {
        var entries = [PieChartDataEntry]()
        
        for value in viewModel.data {
            entries.append(
                .init(
                    value: value
                )
            )
        }
        
        let dataSet = PieChartDataSet(entries: entries, label: "Test")
        dataSet.colors = [.green,.purple,.blue,.brown]
        dataSet.highlightEnabled = false
    }
    
}
