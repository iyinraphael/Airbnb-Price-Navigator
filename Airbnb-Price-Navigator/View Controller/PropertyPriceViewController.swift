//
//  PropertyPriceViewController.swift
//  Airbnb-Price-Navigator
//
//  Created by Iyin Raphael on 10/4/19.
//  Copyright © 2019 Iyin Raphael. All rights reserved.
//

import UIKit
import Charts

class PropertyPriceViewController: PropertyBaseNavViewController {
    
    //MARK:- Properties
    var barChart: BarChartData?
    var predictions: Prediction?
    let bins = ["$0-50", "$50-100", "$100-150", "$150-200", "$200-300", "$300-400", "$400-500", "$500-750", "$750-1000", "$1000+"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.addChild(self)
        navigationController?.setNavigationBarHidden(false, animated: true)
        updatePrice()
    }
    
    private func updatePrice() {
        guard isViewLoaded else {return}
        
        let priceStackView = UIStackView()
        view.addSubview(priceStackView)
        priceStackView.axis = .vertical
        priceStackView.translatesAutoresizingMaskIntoConstraints = false
        priceStackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 100).isActive = true
        priceStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 80).isActive = true
        priceStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80).isActive = true
        
        let barChartView  = HorizontalBarChartView()
        view.addSubview(barChartView)
        barChartView.translatesAutoresizingMaskIntoConstraints = false
        barChartView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 300).isActive = true
        barChartView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        barChartView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        barChartView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
       
        let worthLabel = UILabel()
        worthLabel.text = "Your property could be worth"
        priceStackView.addArrangedSubview(worthLabel)
        
        let valuesLabel = UILabel()
        priceStackView.addArrangedSubview(valuesLabel)
        
        
        var dataEntries = [BarChartDataEntry]()
        if let prediction = predictions {
            valuesLabel.text = "$\(prediction.prediction) / night"
            
            for i in 0..<bins.count {
                
                let dataEntry = BarChartDataEntry(x: Double(i), y: Double(prediction.plotValues[i]))
                dataEntries.append(dataEntry)
                
            }
            
            let dataset = BarChartDataSet(values: dataEntries, label: " ")
            barChart = BarChartData(dataSet: dataset)
            dataset.colors = [UIColor.green]
            dataset.drawValuesEnabled = false
            barChartView.data = barChart
            barChartView.xAxis.labelPosition = .bottom
            barChartView.xAxis.valueFormatter =  IndexAxisValueFormatter(values: bins)
            barChartView.xAxis.labelPosition = XAxis.LabelPosition.bottom
            barChartView.xAxis.granularity = 1
            barChartView.xAxis.granularityEnabled = true
            barChartView.xAxis.labelCount = 10
            barChartView.rightAxis.labelCount = 4
            barChartView.leftAxis.labelCount = 0
            barChartView.xAxis.gridColor = .clear
            barChartView.leftAxis.gridColor = .clear
            barChartView.rightAxis.axisMinimum = 0.0
            barChartView.leftAxis.axisMinimum = 0.0
            barChartView.rightAxis.axisLineColor = .clear
            barChartView.leftAxis.axisLineColor = .clear
        }
        
        
    }
}
