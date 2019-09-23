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
    
    var propertyTypeButton = UIButton(type: .custom)
    var roomTypeButton = UIButton()
    var bedTypesButton = UIButton()
    var submitButton = UIButton()
    
    var property: Property?
    var propertyController = PropertyController()
    
    var dropdown: DropDownTextField = DropDownTextField(frame: CGRect.zero, title: "Practice", options: ["five", "six", "seven"])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(stackview)
        stackview.axis = .vertical
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.spacing = 10.0
        stackview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 58).isActive = true
        stackview.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -140.0).isActive = true
        stackview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40.0).isActive = true
        stackview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40.0).isActive = true
    
        
        
        //MARK: - Header Text
        stackview.addArrangedSubview(headerLabel)
        headerLabel.text = "Find out the value of your property!"
        headerLabel.textAlignment = .center
        headerLabel.font = .boldSystemFont(ofSize: 20.0)
        headerLabel.adjustsFontSizeToFitWidth = true
        headerLabel.numberOfLines = 2
        
        //MARK: - Zipcode
        stackview.addArrangedSubview(zipcodeStackView)
        zipcodeStackView.addArrangedSubview(zipcodeLabel)
        zipcodeStackView.addArrangedSubview(zipcodeTextField)
        zipcodeStackView.axis = .vertical
       
        zipcodeLabel.text = "Zip Code"
        zipcodeLabel.font = .boldSystemFont(ofSize: 12)
        zipcodeTextField.borderStyle = .line
        zipcodeTextField.placeholder = "90210"
        
        //MARK: - Property Type
        stackview.addArrangedSubview(propertyTypeStackView)
        propertyTypeStackView.addArrangedSubview(propertyLabel)
        propertyTypeStackView.addArrangedSubview(propertyTypeTextField)
        propertyTypeStackView.axis = .vertical
        
       
        propertyLabel.text = "Property Type"
        propertyLabel.font = .boldSystemFont(ofSize: 12)
        propertyTypeTextField.borderStyle = .line
        propertyTypeTextField.placeholder = "House"
        
        propertyTypeButton.setImage(UIImage(named: "slide-down"), for: .normal)
        propertyTypeButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        propertyTypeButton.frame = CGRect(x: 0, y: 0, width: 12, height: 12)
        propertyTypeTextField.rightView = propertyTypeButton
        propertyTypeTextField.rightViewMode = .always
        
    
        //MARK: - Room Type
        stackview.addArrangedSubview(roomTypeStackView)
        roomTypeStackView.axis = .vertical
        roomTypeStackView.addArrangedSubview(roomTypeLabel)
        roomTypeLabel.text = "Room Type"
        roomTypeLabel.font = .boldSystemFont(ofSize: 12)
        
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
        bedroomsLabel.font = .boldSystemFont(ofSize: 12)
        bedoroomsTextField.borderStyle = .line
        bedoroomsTextField.placeholder = "0"

        bathroomsStackView.addArrangedSubview(bathroomsLabel)
        bathroomsStackView.addArrangedSubview(bathroomsTextField)
        bathroomsStackView.axis = .vertical

        bathroomsLabel.text = "Bathrooms"
        bathroomsLabel.font = .boldSystemFont(ofSize: 12)
        bathroomsTextField.borderStyle = .line
        bathroomsTextField.placeholder = "0"
       
        //MARK: - Bed Types
        stackview.addArrangedSubview(bedTypesStackView)
        bedTypesStackView.addArrangedSubview(bedTypesLabel)
        bedTypesStackView.addArrangedSubview(bedTypesTextField)
        bedTypesStackView.axis = .vertical
        
        bedTypesLabel.text = "Bed Types"
        bedTypesLabel.font = .boldSystemFont(ofSize: 12)
        bedTypesTextField.placeholder = "Standard Bed"
        bedTypesTextField.rightView = bedTypesButton
        bedTypesTextField.borderStyle = .line
        
        //MARK: - Accommodation
        stackview.addArrangedSubview(accommodatStackView)
        accommodatStackView.addArrangedSubview(accommodateLabel)
        accommodatStackView.addArrangedSubview(accommodatesTextField)
        accommodatStackView.axis = .vertical
        stackview.setCustomSpacing(55, after: accommodatStackView)
        
        accommodateLabel.text = "Accomodates how many guest?"
        accommodateLabel.font = .boldSystemFont(ofSize: 12)
        accommodatesTextField.placeholder = "0"
        accommodatesTextField.borderStyle = .line
        
        //MARK: - Submit button
        stackview.addArrangedSubview(submitButton)
        submitButton.setTitle("Submit", for: .normal)
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.backgroundColor = .lightGray
        
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    private func updateView() {
        
        
        
    }
    

}
