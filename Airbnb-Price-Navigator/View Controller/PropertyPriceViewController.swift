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
    var pricePredict: PricePredict?
    var valuesLabel: UILabel!
    let space: CGFloat = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Appearance.greenGradient
        
        valuesLabel = UILabel()
        valuesLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(valuesLabel)
        valuesLabel.textAlignment = .center
        valuesLabel.textColor = .white
        valuesLabel.numberOfLines = 0
        valuesLabel.adjustsFontSizeToFitWidth = true
        valuesLabel.font = .systemFont(ofSize: space, weight: .bold)
        valuesLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        valuesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: space).isActive = true
        valuesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -space).isActive = true
        
        updatePrice()
        updateForNoData()
    }
    
    private func updatePrice() {
        guard isViewLoaded else {return}
       
        
        if let pricePredict = pricePredict {
            valuesLabel.text = " Your property could be worth $\(pricePredict.prediction) / night"
            print(pricePredict.prediction)
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
