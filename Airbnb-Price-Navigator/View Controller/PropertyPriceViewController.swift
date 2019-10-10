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
    var priceLabel: UILabel!
    var priceStackView: UIStackView!
    
    var barChart: BarChartData?
    var dataset: [ChartDataSet]?
    var predictions: Prediction?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.addChild(self)
        navigationController?.setNavigationBarHidden(false, animated: true)
        updatePrice()
    }
    
    private func updatePrice() {
        guard isViewLoaded else {return}
        priceStackView = UIStackView()
        view.addSubview(priceStackView)
        priceStackView.axis = .vertical
        priceStackView.translatesAutoresizingMaskIntoConstraints = false
        priceStackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 100).isActive = true
        priceStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 80).isActive = true
        priceStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80).isActive = true
        
        let worthLabel = UILabel()
        worthLabel.text = "Your property could be worth"
        priceStackView.addArrangedSubview(worthLabel)
        
        let valuesLabel = UILabel()
        priceStackView.addArrangedSubview(valuesLabel)
        if let prediction = predictions {
            valuesLabel.text = "$\(prediction.prediction)"
        }
        
    }
}
