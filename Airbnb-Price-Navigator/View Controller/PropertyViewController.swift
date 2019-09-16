//
//  PropertyViewController.swift
//  Airbnb-Price-Navigator
//
//  Created by Iyin Raphael on 9/14/19.
//  Copyright © 2019 Iyin Raphael. All rights reserved.
//

import UIKit

class PropertyViewController: UIViewController {

    //MARK: - Properties
    let stackview = UIStackView()
    let zipcodeStackView = UIStackView()
    let propertyTypeStackView = UIStackView()
    let roomTypeStackView = UIStackView()
    let bedroomsStackView =  UIStackView()
    let bathroomsStackView = UIStackView()
    let bedAndBathStackView = UIStackView()
    let bedTypesStackView = UIStackView()
    let accommodatStackView = UIStackView()

    var zipcodeTextField = UITextField()
    var propertyTypeTextField = UITextField()
    var roomTypeTextField = UITextField()
    var bedorooms = UITextField()
    var bathrooms = UITextField()
    var bedTypes =  UITextField()
    var accommodates = UITextField()

    
    var headerLabel = UILabel()
    var zipcodeLabel = UILabel()
    var propertyLabel = UILabel()
    var roomTypeLabel = UILabel()
    var bedroomsLabel = UILabel()
    var bathroomsLabel = UILabel()
    var bedTypesLabel = UILabel()
    var accommodateLabel = UILabel()
    
    var propertyTypeButton = UIButton()
    var roomTypeButton = UIButton()
    var bedTypesButton = UIButton()
    var submitButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(stackview)
        stackview.axis = .vertical
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.spacing = 5.0
        stackview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        stackview.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50.0).isActive = true
        stackview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15.0).isActive = true
        stackview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15.0).isActive = true
        
        
        stackview.addArrangedSubview(headerLabel)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.text = "Find out the value of your propery"
        
        //MARK: - Zipcode
        stackview.addArrangedSubview(zipcodeStackView)
        zipcodeStackView.axis = .vertical
        zipcodeStackView.translatesAutoresizingMaskIntoConstraints = false
        zipcodeStackView.addArrangedSubview(zipcodeLabel)
        zipcodeLabel.text = "Zipcode"
        zipcodeStackView.addArrangedSubview(zipcodeTextField)
        zipcodeTextField.borderStyle = .line
      
        //MARK: - Property Type
        stackview.addArrangedSubview(propertyTypeStackView)
        propertyTypeStackView.axis = .vertical
        propertyTypeStackView.translatesAutoresizingMaskIntoConstraints = false
        propertyTypeStackView.addArrangedSubview(propertyLabel)
        propertyLabel.text = "Property Type"
        propertyTypeStackView.addArrangedSubview(propertyTypeTextField)
        propertyTypeTextField.borderStyle = .line
        propertyTypeTextField.rightView = propertyTypeButton
    
        
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
  

}
