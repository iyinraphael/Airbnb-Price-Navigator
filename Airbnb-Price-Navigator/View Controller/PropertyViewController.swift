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
    var bedoroomsTextField = UITextField()
    var bathroomsTextField = UITextField()
    var bedTypesTextField =  UITextField()
    var accommodatesTextField = UITextField()

    
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
        
        
        //MARK: - Header Text
        stackview.addArrangedSubview(headerLabel)
        headerLabel.text = "Find out the value of your propery"
        
        //MARK: - Zipcode
        stackview.addArrangedSubview(zipcodeStackView)
        zipcodeStackView.axis = .vertical
        zipcodeStackView.addArrangedSubview(zipcodeLabel)
        zipcodeLabel.text = "Zipcode"
        zipcodeStackView.addArrangedSubview(zipcodeTextField)
        zipcodeTextField.borderStyle = .line
        zipcodeTextField.placeholder = "90210"
      
        //MARK: - Property Type
        stackview.addArrangedSubview(propertyTypeStackView)
        propertyTypeStackView.axis = .vertical
        propertyTypeStackView.addArrangedSubview(propertyLabel)
        propertyLabel.text = "Property Type"
        propertyTypeStackView.addArrangedSubview(propertyTypeTextField)
        propertyTypeTextField.borderStyle = .line
        propertyTypeTextField.placeholder = "House"
        propertyTypeTextField.rightView = propertyTypeButton
    
        //MARK: - Room Type
        stackview.addArrangedSubview(roomTypeStackView)
        roomTypeStackView.axis = .vertical
        roomTypeStackView.addArrangedSubview(roomTypeLabel)
        roomTypeLabel.text = "Room Type"
        
        roomTypeStackView.addArrangedSubview(roomTypeTextField)
        roomTypeTextField.borderStyle = .line
        roomTypeTextField.placeholder = "Entire Property"
        roomTypeTextField.rightView = roomTypeButton
        
        //MARK: - Bedtroom and Bathroom
        stackview.addArrangedSubview(bedAndBathStackView)
        bedAndBathStackView.axis = .horizontal
        bedAndBathStackView.distribution = .fillEqually
        bedAndBathStackView.spacing = 5.0
        bedAndBathStackView.addArrangedSubview(bedroomsStackView)
        bedAndBathStackView.addArrangedSubview(bathroomsStackView)
        
        bedAndBathStackView.axis = .horizontal
        
        bedroomsStackView.addArrangedSubview(bedroomsLabel)
        bedroomsStackView.addArrangedSubview(bedoroomsTextField)
        bedroomsStackView.axis = .vertical
    
        bedroomsLabel.text = "Bedrooms"

        bedoroomsTextField.borderStyle = .line
        bedoroomsTextField.placeholder = "0"

        bathroomsStackView.addArrangedSubview(bathroomsLabel)
        bathroomsStackView.addArrangedSubview(bathroomsTextField)
        bathroomsStackView.axis = .vertical

        bathroomsLabel.text = "Bathrooms"

        bathroomsTextField.borderStyle = .line
        bathroomsTextField.placeholder = "0"
       
        //MARK: - Bed Types
        
        stackview.addArrangedSubview(bedTypesStackView)
        bedTypesStackView.addArrangedSubview(bedTypesLabel)
        bedTypesStackView.addArrangedSubview(bedTypesTextField)
        bedTypesStackView.axis = .vertical
        
        bedTypesLabel.text = "Bed Types"
        bedTypesTextField.placeholder = "Standard Bed"
        bedTypesTextField.rightView = bedTypesButton
        bedTypesTextField.borderStyle = .line
        
        
        
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
  

}
