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
        let colors: [UIColor]
    }
    
    let categories = ["Remaining","Entertainment", "Expenses", "Groceries", "Emergency", "Other"]
    
    let bugdet: Double = 0
    
    private let chartView: PieChartView = {
        let chart = PieChartView()
        chart.usePercentValuesEnabled = false
        chart.isUserInteractionEnabled = false
        chart.legend.enabled = true
        chart.legend.verticalAlignment = .bottom
        chart.legend.orientation = .horizontal
        chart.legend.font = UIFont.systemFont(ofSize: 15)
        chart.holeColor = .systemGray4
        chart.holeRadiusPercent = 0.45
        chart.transparentCircleRadiusPercent = 0.0
        chart.animate(xAxisDuration: 2, yAxisDuration: 2)
        return chart
    }()
    
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(chartView)
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
        
        /*for value in viewModel.data {
            entries.append(
                .init(
                    value: value
                )
            )
            print(value)
        }*/
        
        for x in 0..<6 {
            entries.append(
                .init(
                    value: viewModel.data[x],
                    label: categories[x]
                )
            )
        }
        
        let dataSet = PieChartDataSet(entries: entries, label: "")
        dataSet.colors = viewModel.colors
        dataSet.valueTextColor = .clear
        dataSet.entryLabelColor = .clear
        dataSet.highlightEnabled = false
        let data = PieChartData(dataSet: dataSet)
        chartView.data = data
    }
    
}
