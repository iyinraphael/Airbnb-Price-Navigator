//
//  PropertyPriceViewController.swift
//  Airbnb-Price-Navigator
//
//  Created by Iyin Raphael on 10/4/19.
//  Copyright © 2019 Iyin Raphael. All rights reserved.
//

import UIKit

class PropertyPriceViewController: PropertyBaseNavViewController {
    
    //MARK:- UI Oultets
    var valuesLabel: UILabel!
    var priceView: UIView!
    var doneButton: UIButton!
    
    //MARK:- Properties
    var pricePredict: PricePredict?
    let space: CGFloat = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        
        valuesLabel = UILabel()
        view.addSubview(valuesLabel)
        valuesLabel.translatesAutoresizingMaskIntoConstraints = false
        valuesLabel.textAlignment = .center
        valuesLabel.textColor = .white
        valuesLabel.numberOfLines = 0
        valuesLabel.adjustsFontSizeToFitWidth = true
        valuesLabel.font = .systemFont(ofSize: space, weight: .bold)
        valuesLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        valuesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: space).isActive = true
        valuesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -space).isActive = true
        
        doneButton = UIButton()
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        doneButton.layer.masksToBounds = true
        doneButton.layer.cornerRadius =  space / 4
        doneButton.setTitle("Done", for: .normal)
        doneButton.setTitleColor(Appearance.greenGradient, for: .normal)
        doneButton.tintColor =  Appearance.greenGradient
        
        let height = view.frame.height
        priceView = UILabel(frame: CGRect(x: 0, y: height / 2, width: view.frame.width, height: height / 2))
        priceView.layer.masksToBounds = true
        priceView.layer.cornerRadius = space * 2
        priceView.backgroundColor = .white
        priceView.addSubview(doneButton)
        
        view.addSubview(priceView)
        
        NSLayoutConstraint.activate([
            doneButton.topAnchor.constraint(equalTo: priceView.topAnchor, constant: space),
            doneButton.trailingAnchor.constraint(equalTo: priceView.trailingAnchor, constant: -space)
        ])
        
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
 
        
        let textView = UITextView()
        textView.isEditable = false
        textView.sizeToFit()
        textView.textAlignment = .center
        textView.text = """
                    Our data is gathered from Inside Airbnb,and it looks like your ZIP code is not included in the data set.
                    The national average for the parameters entered is $281/night.
                    """
    
    }
    
    @objc func dismissView() {
        presentingViewController?.dismiss(animated: true)
    }
}
