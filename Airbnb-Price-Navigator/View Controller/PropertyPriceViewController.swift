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
    var worthLabel: UILabel!
    var priceLabel: UILabel!
    var valuesLabel: UILabel!
    var priceStackView: UIStackView!
    
    var barChart: BarChartData?
    var dataset: [ChartDataSet]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
        updatePrice()
    }
    
    private func updatePrice() {
        priceStackView = UIStackView()
        view.addSubview(priceStackView)
        priceStackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 100).isActive = true
        priceStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 80).isActive = true
        priceStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80).isActive = true
    }
}
