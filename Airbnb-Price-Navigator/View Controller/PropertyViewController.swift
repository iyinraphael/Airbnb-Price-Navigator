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
    var stackview: UIStackView!
    var zipcodeStackView: UIStackView!
    var roomTypeStackView: UIStackView!
    var propertyTypeStackView: UIStackView!
    var bedroomsStackView: UIStackView!
    var bathroomsStackView:  UIStackView!
    var bedAndBathStackView: UIStackView!
    var bedTypesStackView: UIStackView!
    var accommodatStackView: UIStackView!

    var bedoroomsTextField = UITextField()
    var bathroomsTextField = UITextField()
    var bedTypesTextField =  UITextField()
    var accommodatesTextField = UITextField()

    var propertyLabel: UILabel!
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
    var bool = true
    
    var dropDownPropertyTextfield: DropDownTextField!
    var dropDownRoomTypeTextfield: DropDownTextField!
    private var flavourOptions = ["Chocolate", "Vanilla", "Strawberry", "Banana", "Lime"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: - Header Text and Zip Code label
        
        stackview = UIStackView()
        view.addSubview(stackview)
        
        stackview.axis = .vertical
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.distribution = .fillEqually
        stackview.spacing = 50.0
        stackview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
        stackview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40.0).isActive = true
        stackview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40.0).isActive = true

        
        
        let _: UILabel = {
            let headerLabel = UILabel()
            stackview.addArrangedSubview(headerLabel)
            headerLabel.text = "Find out the value of your property!"
            headerLabel.textAlignment = .center
            headerLabel.font = .boldSystemFont(ofSize: 20.0)
            headerLabel.adjustsFontSizeToFitWidth = true
            headerLabel.numberOfLines = 2
           
            return headerLabel
        }()
        
        zipcodeStackView = UIStackView()
        stackview.addArrangedSubview(zipcodeStackView)
        zipcodeStackView.axis = .vertical

        let _: UILabel = {
            let zipcodeLabel = UILabel()
            zipcodeLabel.text = "Zip Code"
            zipcodeLabel.font = .boldSystemFont(ofSize: 12)
            zipcodeStackView.addArrangedSubview(zipcodeLabel)
            
            return zipcodeLabel
        }()
        
        let zipcodeTextField: UITextField = {
            let zipcodeTextField = UITextField()
            zipcodeTextField.borderStyle = .line
            zipcodeTextField.placeholder = "90210"
            zipcodeStackView.addArrangedSubview(zipcodeTextField)
            
            return zipcodeTextField
        }()
        
        
        //MARK: - Property Type
        addDropDownPropertyTextfield()

    
        //MARK: - Room Type
        addDropDownRoomTypeTextfield()
//        stackview.addArrangedSubview(roomTypeStackView)
//        roomTypeStackView.axis = .vertical
//        roomTypeStackView.addArrangedSubview(roomTypeLabel)
//        roomTypeLabel.text = "Room Type"
//        roomTypeLabel.font = .boldSystemFont(ofSize: 12)
//
//        roomTypeStackView.addArrangedSubview(roomTypeTextField)
//        roomTypeTextField.borderStyle = .line
//        roomTypeTextField.placeholder = "Entire Property"
//        roomTypeTextField.rightView = roomTypeButton
        
        //MARK: - Bedtroom and Bathroom
//        stackview.addArrangedSubview(bedAndBathStackView)
//        bedAndBathStackView.axis = .horizontal
//        bedAndBathStackView.distribution = .fillEqually
//        bedAndBathStackView.spacing = 5.0
//        bedAndBathStackView.addArrangedSubview(bedroomsStackView)
//        bedAndBathStackView.addArrangedSubview(bathroomsStackView)
//
//        bedAndBathStackView.axis = .horizontal
//
//        bedroomsStackView.addArrangedSubview(bedroomsLabel)
//        bedroomsStackView.addArrangedSubview(bedoroomsTextField)
//        bedroomsStackView.axis = .vertical
//
//        bedroomsLabel.text = "Bedrooms"
//        bedroomsLabel.font = .boldSystemFont(ofSize: 12)
//        bedoroomsTextField.borderStyle = .line
//        bedoroomsTextField.placeholder = "0"
//
//        bathroomsStackView.addArrangedSubview(bathroomsLabel)
//        bathroomsStackView.addArrangedSubview(bathroomsTextField)
//        bathroomsStackView.axis = .vertical

//        bathroomsLabel.text = "Bathrooms"
//        bathroomsLabel.font = .boldSystemFont(ofSize: 12)
//        bathroomsTextField.borderStyle = .line
//        bathroomsTextField.placeholder = "0"
//
        //MARK: - Bed Types
//        stackview.addArrangedSubview(bedTypesStackView)
//        bedTypesStackView.addArrangedSubview(bedTypesLabel)
//        bedTypesStackView.addArrangedSubview(bedTypesTextField)
//        bedTypesStackView.axis = .vertical
//
//        bedTypesLabel.text = "Bed Types"
//        bedTypesLabel.font = .boldSystemFont(ofSize: 12)
//        bedTypesTextField.placeholder = "Standard Bed"
//        bedTypesTextField.rightView = bedTypesButton
//        bedTypesTextField.borderStyle = .line
        
        //MARK: - Accommodation
//        stackview.addArrangedSubview(accommodatStackView)
//        accommodatStackView.addArrangedSubview(accommodateLabel)
//        accommodatStackView.addArrangedSubview(accommodatesTextField)
//        accommodatStackView.axis = .vertical
//        stackview.setCustomSpacing(55, after: accommodatStackView)
//
//        accommodateLabel.text = "Accomodates how many guest?"
//        accommodateLabel.font = .boldSystemFont(ofSize: 12)
//        accommodatesTextField.placeholder = "0"
//        accommodatesTextField.borderStyle = .line
        
        //MARK: - Submit button
//        stackview.addArrangedSubview(submitButton)
//        submitButton.setTitle("Submit", for: .normal)
//        submitButton.setTitleColor(.white, for: .normal)
//        submitButton.backgroundColor = .lightGray
//
    }
    
    private func addDropDownPropertyTextfield() {
        let lm = view.layoutMargins
        let height: CGFloat = 30.0
        let dropDownFrame = CGRect(x: lm.left, y: lm.top + 60, width: 296, height: height)
        
        propertyLabel = UILabel()
        propertyLabel.text = "Property Type"
        propertyLabel.font = .boldSystemFont(ofSize: 12.0)
        
        dropDownPropertyTextfield = DropDownTextField(frame: dropDownFrame, title: "House", options: flavourOptions)
        dropDownPropertyTextfield.delegate = self
        
        propertyTypeStackView = UIStackView()
        view.addSubview(propertyTypeStackView)
        
        propertyTypeStackView.translatesAutoresizingMaskIntoConstraints = false
        propertyTypeStackView.axis = .vertical
        propertyTypeStackView.topAnchor.constraint(equalTo: stackview.bottomAnchor, constant: 10).isActive = true
        propertyTypeStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40.0).isActive = true
        propertyTypeStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40.0).isActive = true
        
        propertyTypeStackView.addArrangedSubview(propertyLabel)
        propertyTypeStackView.addArrangedSubview(dropDownPropertyTextfield)
        
      
    }
    
    private func addDropDownRoomTypeTextfield() {
        let lm = view.layoutMargins
        let height: CGFloat = 30.0
        let dropDownFrame = CGRect(x: lm.left, y: lm.top + 60, width: 296, height: height)
        
        let roomTypeLabel = UILabel()
        roomTypeLabel.text = "Room Type"
        roomTypeLabel.font = .boldSystemFont(ofSize: 12.0)
    
        dropDownRoomTypeTextfield = DropDownTextField(frame: dropDownFrame, title: "Entire Property", options: flavourOptions)
        dropDownRoomTypeTextfield.delegate = self
    
        
        
        roomTypeStackView = UIStackView()
        view.addSubview(roomTypeStackView)
        
        roomTypeStackView.translatesAutoresizingMaskIntoConstraints = false
        roomTypeStackView.axis = .vertical
        roomTypeStackView.topAnchor.constraint(equalTo: stackview.bottomAnchor, constant: 60).isActive = true
        roomTypeStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        roomTypeStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        
        roomTypeStackView.addArrangedSubview(roomTypeLabel)
        roomTypeStackView.addArrangedSubview(dropDownRoomTypeTextfield)
        
        
        
        
        
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    private func updateView() {
        
        
        
    }
    

}


extension PropertyViewController: DropDownTextFieldDelegate {
    
    func menuDidAnimate(up: Bool) {
        
        
        if dropDownPropertyTextfield.isDroppedDown == true {
            view.sendSubviewToBack(roomTypeStackView)
        } else {
            view.bringSubviewToFront(roomTypeStackView)
        }
    }
    
    func optionSelected(option: String) {
        print("option selected: \(option)")
    }
    
    
}
