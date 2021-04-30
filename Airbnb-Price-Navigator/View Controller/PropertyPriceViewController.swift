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
    var titleLabel: UILabel!
    var priceView: UIView!
    var doneButton: UIButton!
    
    //MARK:- Properties
    var pricePredict: PricePredict?
    let space: CGFloat = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear

        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Your property could be worth"
        titleLabel.font = Appearance.titleFont
        titleLabel.textColor = .black
        
        valuesLabel = UILabel()
        valuesLabel.translatesAutoresizingMaskIntoConstraints = false
        valuesLabel.textAlignment = .center
        valuesLabel.textColor = Appearance.greenGradient
        valuesLabel.adjustsFontSizeToFitWidth = true
        valuesLabel.font = Appearance.headerFont
        
        doneButton = UIButton()
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.isUserInteractionEnabled = true
        doneButton.addTarget(self, action: #selector(removeViewFromParent), for: .touchUpInside)
        doneButton.layer.masksToBounds = true
        doneButton.layer.cornerRadius =  space / 2
        doneButton.setTitle("Done", for: .normal)
        doneButton.titleLabel?.font  = Appearance.labelFont
        doneButton.setTitleColor(Appearance.greenGradient, for: .normal)
        doneButton.tintColor =  Appearance.greenGradient
        doneButton.backgroundColor = Appearance.greenGradientShade
        
        let height = view.frame.height
        priceView = UILabel(frame: CGRect(x: 0, y: height / 2, width: view.frame.width, height: height / 2))
        priceView.layer.masksToBounds = true
        priceView.layer.cornerRadius = space * 2
        priceView.backgroundColor = .white
        
        view.addSubview(priceView)
        view.addSubview(doneButton)
        view.addSubview(valuesLabel)
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            doneButton.topAnchor.constraint(equalTo: priceView.topAnchor, constant: space),
            doneButton.trailingAnchor.constraint(equalTo: priceView.trailingAnchor, constant: -space),
            doneButton.heightAnchor.constraint(equalToConstant: space),
            doneButton.widthAnchor.constraint(equalToConstant: space * 2),
            
            titleLabel.topAnchor.constraint(equalTo: priceView.topAnchor, constant: space * 3),
            titleLabel.centerXAnchor.constraint(equalTo: priceView.centerXAnchor),
            
            valuesLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: space * 3),
            valuesLabel.centerXAnchor.constraint(equalTo: priceView.centerXAnchor)
        ])
        
        updatePrice()
        updateForNoData()
    }
    
    private func updatePrice() {
        guard isViewLoaded else {return}
       
        
        if let pricePredict = pricePredict {
            valuesLabel.text = " $\(pricePredict.prediction)/night"
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
    
    @objc func removeViewFromParent() {
        self.dismiss(animated: true)
    }
}
