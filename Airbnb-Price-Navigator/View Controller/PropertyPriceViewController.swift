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
    
    var pricePredict: PricePredict?
    let bins = ["$0-50", "$50-100", "$100-150", "$150-200", "$200-300", "$300-400", "$400-500", "$500-750", "$750-1000", "$1000+"]
    let greenGradient = UIColor(red: 0.0/255.0, green: 160.0/255.0, blue: 134.0/255.0, alpha: 1)
    
    var valuesLabel: UILabel!
    var priceStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        priceStackView = UIStackView()
        view.addSubview(priceStackView)
        priceStackView.axis = .vertical
        priceStackView.translatesAutoresizingMaskIntoConstraints = false
        priceStackView.alignment = .fill
        priceStackView.distribution = .fillProportionally
        priceStackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 100).isActive = true
        priceStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80).isActive = true
        priceStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80).isActive = true
        
        let worthLabel = UILabel()
        worthLabel.adjustsFontSizeToFitWidth = true
        worthLabel.text = "Your property could be worth"
        worthLabel.font = .systemFont(ofSize: 20)
        priceStackView.addArrangedSubview(worthLabel)
        
        valuesLabel = UILabel()
        valuesLabel.textAlignment = .center
        valuesLabel.adjustsFontSizeToFitWidth = true
        valuesLabel.font = .systemFont(ofSize: 45.0, weight: .bold)
        priceStackView.addArrangedSubview(valuesLabel)
        
        updatePrice()
        updateForNoData()
        
        
    }
    
    private func updatePrice() {
        guard isViewLoaded else {return}
        
        let barChartView  = HorizontalBarChartView()
        view.addSubview(barChartView)
        barChartView.translatesAutoresizingMaskIntoConstraints = false
        barChartView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 300).isActive = true
        barChartView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        barChartView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        barChartView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
       
        
        
        var dataEntries = [BarChartDataEntry]()
        if let pricePredict = pricePredict {
            valuesLabel.text = "$\(pricePredict.prediction) / night"
            print(pricePredict.prediction)
            
            for i in 0..<bins.count {
                
                let dataEntry = BarChartDataEntry(x: Double(i), y: Double(pricePredict.plotValues[i]))
                dataEntries.append(dataEntry)
                
            }
            
            let dataset = BarChartDataSet(entries: dataEntries, label: " ")
            barChart = BarChartData(dataSet: dataset)
            barChart?.barWidth = 0.5
            dataset.colors = [greenGradient]
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
    
    
    private func updateForNoData() {
        
        guard let pricePredict = pricePredict else {return}
        
        for values in pricePredict.plotValues {
            if values != 0 {
                return
            }
        }
        
        valuesLabel.text = "$\(281) / night"
        
        let backGroundView = UIView()
        view.addSubview(backGroundView)
        backGroundView.backgroundColor =  UIColor.black.withAlphaComponent(0.5)
        backGroundView.translatesAutoresizingMaskIntoConstraints = false
        backGroundView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 300).isActive = true
        backGroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        backGroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        backGroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        backGroundView.addSubview(stackView)
        stackView.backgroundColor = .white
        stackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 350).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150).isActive = true
        
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.backgroundColor = .white
        stackView.addArrangedSubview(textLabel)
        textLabel.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 60).isActive = true
        textLabel.text =  "No Data For Your Zip Code"
        textLabel.font = .systemFont(ofSize: 20.0, weight: .medium)
        textLabel.textAlignment = .center
 
        
        let textView = UITextView()
        stackView.addArrangedSubview(textView)
        textView.isEditable = false
        textView.sizeToFit()
        textView.textAlignment = .center
        textView.text = """
                    Our data is gathered from Inside Airbnb,and it looks like your ZIP code is not included in the data set.
                    The national average for the parameters entered is $281/night.
                    """
    
    }
}
