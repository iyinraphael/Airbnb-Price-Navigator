//
//  PropertyViewController.swift
//  Airbnb-Price-Navigator
//
//  Created by Iyin Raphael on 9/14/19.
//  Copyright © 2019 Iyin Raphael. All rights reserved.
//

import UIKit
import iOSDropDown

 
class PropertyViewController: PropertyBaseNavViewController {
    

//MARK: - Properties
    var stackview: UIStackView!
    var bedroomTextField: UITextField!
    var bathroomsTextField: UITextField!
    @objc dynamic var accommodatesTextField: UITextField!
    var zipcodeTextField: UITextField!
    var bedCountTextField: UITextField!
    
    var dropDownPropertyTextfield: DropDown!
    var dropDownRoomTypeTextfield: DropDown!
    var dropDownBedTypeTextfield: DropDown!
    var submitButton: UIButton!
    let network = Network()
    
    let roomTypes = ["Entire home/apt", "Private Room", "Shared Room"]
    let bedTypes = ["Real Bed",  "Couch", "Futon", "Pull-Out Sofa", "Airbed"]
    let propertyTypes = ["House", "Apartment", "Condominium", "Townhouse",
                         "Loft", "Guest Suite", "Bungalow", "Villa", "Other"]
    var roomType: String?
    var bedType: String?
    
    
//MARK:- UI SETUP
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let radius: CGFloat = 5
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardDidHideNotification,
                                               object: nil)
       

        let headerLabel = UILabel()
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.text = "Find out the value of your property!"
        headerLabel.numberOfLines = 0
        headerLabel.textAlignment = .center
        headerLabel.font = Appearance.headerFont
        
        let zipcodeLabel = UILabel()
        zipcodeLabel.translatesAutoresizingMaskIntoConstraints = false
        zipcodeLabel.text = "Zip Code"
        zipcodeLabel.font = Appearance.labelFont
        zipcodeTextField = UITextField(frame: .zero)
        zipcodeTextField.translatesAutoresizingMaskIntoConstraints = false
        zipcodeTextField.delegate = self
        zipcodeTextField.layer.borderWidth = 1.0
        zipcodeTextField.layer.borderColor = Appearance.textFieldBorderColor
        zipcodeTextField.layer.cornerRadius = radius
        zipcodeTextField.font = Appearance.textFieldFont
        zipcodeTextField.placeholder = "90210"
        
        let propertyLabel = UILabel()
        propertyLabel.translatesAutoresizingMaskIntoConstraints = false
        propertyLabel.text = "Property Type"
        propertyLabel.font = Appearance.labelFont
        dropDownPropertyTextfield = DropDown(frame: .zero)
        dropDownPropertyTextfield.optionArray = propertyTypes
        dropDownPropertyTextfield.placeholder = propertyTypes[0]
        dropDownPropertyTextfield.checkMarkEnabled = false
        dropDownPropertyTextfield.selectedRowColor = Appearance.greenGradient
        dropDownPropertyTextfield.isSearchEnable = false
        dropDownPropertyTextfield.translatesAutoresizingMaskIntoConstraints = false
        dropDownPropertyTextfield.delegate = self
        dropDownPropertyTextfield.font = Appearance.textFieldFont
        dropDownPropertyTextfield.borderWidth = 1.0
        dropDownPropertyTextfield.layer.borderColor = Appearance.textFieldBorderColor
        dropDownPropertyTextfield.layer.cornerRadius = radius
        
        let roomTypeLabel = UILabel()
        roomTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        roomTypeLabel.text = "Room Type"
        roomTypeLabel.font = Appearance.labelFont
        dropDownRoomTypeTextfield = DropDown(frame: .zero)
        dropDownRoomTypeTextfield.optionArray = roomTypes
        dropDownPropertyTextfield.placeholder = roomTypes[0]
        dropDownRoomTypeTextfield.checkMarkEnabled = false
        dropDownRoomTypeTextfield.selectedRowColor = Appearance.greenGradient
        dropDownRoomTypeTextfield.isSearchEnable = false
        dropDownRoomTypeTextfield.translatesAutoresizingMaskIntoConstraints = false
        dropDownRoomTypeTextfield.font = Appearance.textFieldFont
        dropDownRoomTypeTextfield.delegate = self
        dropDownRoomTypeTextfield.borderWidth = 1.0
        dropDownRoomTypeTextfield.layer.borderColor = Appearance.textFieldBorderColor
        dropDownRoomTypeTextfield.layer.cornerRadius = radius
        
        let bedroomsLabel = UILabel()
        bedroomsLabel.translatesAutoresizingMaskIntoConstraints = false
        bedroomsLabel.text = "Bedrooms"
        bedroomsLabel.font = Appearance.labelFont
        bedroomTextField = UITextField()
        bedroomTextField.translatesAutoresizingMaskIntoConstraints = false
        bedroomTextField.delegate = self
        bedroomTextField.layer.borderWidth = 1.0
        bedroomTextField.font = Appearance.textFieldFont
        bedroomTextField.layer.borderColor = Appearance.textFieldBorderColor
        bedroomTextField.placeholder = "# of Bedrooms"
        bedroomTextField.layer.cornerRadius = radius
        
        let bathroomsLabel = UILabel()
        bathroomsLabel.translatesAutoresizingMaskIntoConstraints = false
        bathroomsLabel.text = "Bathrooms"
        bathroomsLabel.font = Appearance.labelFont
        bathroomsTextField = UITextField()
        bathroomsTextField.translatesAutoresizingMaskIntoConstraints = false
        bathroomsTextField.delegate = self
        bathroomsTextField.layer.borderWidth = 1.0
        bathroomsTextField.font = Appearance.textFieldFont
        bathroomsTextField.layer.borderColor = Appearance.textFieldBorderColor
        bathroomsTextField.placeholder = "# of Bathrooms"
        bathroomsTextField.layer.cornerRadius = radius
        
        let bedTypesLabel = UILabel()
        bedTypesLabel.translatesAutoresizingMaskIntoConstraints = false
        bedTypesLabel.text = "Bed Types"
        bedTypesLabel.font = Appearance.labelFont
        dropDownBedTypeTextfield = DropDown()
        dropDownBedTypeTextfield.optionArray = bedTypes
        dropDownBedTypeTextfield.placeholder = bedTypes[0]
        dropDownBedTypeTextfield.checkMarkEnabled = false
        dropDownBedTypeTextfield.selectedRowColor = Appearance.greenGradient
        dropDownBedTypeTextfield.isSearchEnable = false
        dropDownBedTypeTextfield.translatesAutoresizingMaskIntoConstraints = false
        dropDownBedTypeTextfield.font = Appearance.textFieldFont
        dropDownBedTypeTextfield.delegate = self
        dropDownBedTypeTextfield.borderWidth = 1.0
        dropDownBedTypeTextfield.layer.borderColor = Appearance.textFieldBorderColor
        dropDownBedTypeTextfield.layer.cornerRadius = radius
        
        let bedLabel = UILabel()
        bedLabel.translatesAutoresizingMaskIntoConstraints = false
        bedLabel.text = "Bed"
        bedLabel.font = Appearance.labelFont
        bedCountTextField = UITextField()
        bedCountTextField.translatesAutoresizingMaskIntoConstraints = false
        bedCountTextField.font = Appearance.textFieldFont
        bedCountTextField.placeholder = "# of Beds"
        bedCountTextField.layer.borderWidth = 1.0
        bedCountTextField.layer.borderColor = Appearance.textFieldBorderColor
        bedCountTextField.layer.cornerRadius = radius
        
        let accommodateLabel = UILabel()
        accommodateLabel.translatesAutoresizingMaskIntoConstraints = false
        accommodateLabel.text = "Accomodates how many guest?"
        accommodateLabel.font = Appearance.labelFont
        accommodatesTextField = UITextField(frame: .zero)
        accommodatesTextField.translatesAutoresizingMaskIntoConstraints = false
        accommodatesTextField.placeholder = "0"
        accommodatesTextField.layer.borderWidth = 1.0
        accommodatesTextField.delegate = self
        accommodatesTextField.font = Appearance.textFieldFont
        accommodatesTextField.layer.borderColor = Appearance.textFieldBorderColor
        accommodatesTextField.layer.cornerRadius = radius

        
        view.addSubview(headerLabel)
        view.addSubview(zipcodeLabel)
        view.addSubview(zipcodeTextField)
        view.addSubview(propertyLabel)
        view.addSubview(dropDownPropertyTextfield)
        view.addSubview(roomTypeLabel)
        view.addSubview(dropDownRoomTypeTextfield)
        view.addSubview(bedroomsLabel)
        view.addSubview(bedroomTextField)
        view.addSubview(bathroomsLabel)
        view.addSubview(bathroomsTextField)
        view.addSubview(bedTypesLabel)
        view.addSubview(dropDownBedTypeTextfield)
        view.addSubview(bedLabel)
        view.addSubview(bedCountTextField)
        view.addSubview(accommodateLabel)
        view.addSubview(accommodatesTextField)
        
        submitButton = UIButton()
        submitButton.isEnabled = true
        view.addSubview(submitButton)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.tag = 6
        submitButton.addTarget(self, action: #selector(displayPrice), for: .touchUpInside)
        submitButton.setTitle("Submit", for: .normal)
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.backgroundColor = Appearance.greenGradient
        submitButton.layer.masksToBounds = true
        submitButton.layer.cornerRadius = radius
        
        let space: CGFloat = 20
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: space),
            headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: space),
            headerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -space),
            
            zipcodeLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: space * 2),
            zipcodeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: space),
            zipcodeTextField.topAnchor.constraint(equalTo: zipcodeLabel.bottomAnchor),
            zipcodeTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: space),
            zipcodeTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -space),
            zipcodeTextField.heightAnchor.constraint(equalToConstant: space * 3/2),
            
            propertyLabel.topAnchor.constraint(equalTo: zipcodeTextField.bottomAnchor, constant: space / 4),
            propertyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: space),
            dropDownPropertyTextfield.topAnchor.constraint(equalTo: propertyLabel.bottomAnchor),
            dropDownPropertyTextfield.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: space),
            dropDownPropertyTextfield.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -space),
            dropDownPropertyTextfield.heightAnchor.constraint(equalToConstant: space * 3/2),
            
            roomTypeLabel.topAnchor.constraint(equalTo: dropDownPropertyTextfield.bottomAnchor, constant: space / 4),
            roomTypeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: space),
            dropDownRoomTypeTextfield.topAnchor.constraint(equalTo: roomTypeLabel.bottomAnchor),
            dropDownRoomTypeTextfield.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: space),
            dropDownRoomTypeTextfield.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -space),
            dropDownRoomTypeTextfield.heightAnchor.constraint(equalToConstant: space * 3/2),
            
            bedTypesLabel.topAnchor.constraint(equalTo: dropDownRoomTypeTextfield.bottomAnchor, constant: space / 4),
            bedTypesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: space),
            dropDownBedTypeTextfield.topAnchor.constraint(equalTo: bedTypesLabel.bottomAnchor),
            dropDownBedTypeTextfield.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: space),
            dropDownBedTypeTextfield.widthAnchor.constraint(equalTo: dropDownRoomTypeTextfield.widthAnchor, multiplier: 0.49),
            dropDownBedTypeTextfield.heightAnchor.constraint(equalToConstant: space * 3/2),
            
            bedLabel.topAnchor.constraint(equalTo: dropDownRoomTypeTextfield.bottomAnchor, constant: space / 4),
            bedLabel.leadingAnchor.constraint(equalTo: dropDownBedTypeTextfield.trailingAnchor, constant: space / 4),
            bedCountTextField.topAnchor.constraint(equalTo: bedLabel.bottomAnchor),
            bedCountTextField.leadingAnchor.constraint(equalTo: dropDownBedTypeTextfield.trailingAnchor, constant: space / 6),
            bedCountTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -space),
            bedCountTextField.heightAnchor.constraint(equalToConstant: space * 3/2),
            
            bedroomsLabel.topAnchor.constraint(equalTo: dropDownBedTypeTextfield.bottomAnchor, constant: space / 4),
            bedroomsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: space),
            bedroomTextField.topAnchor.constraint(equalTo: bedroomsLabel.bottomAnchor),
            bedroomTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: space),
            bedroomTextField.widthAnchor.constraint(equalTo: dropDownRoomTypeTextfield.widthAnchor, multiplier: 0.49),
            bedroomTextField.heightAnchor.constraint(equalToConstant: space * 3/2),
            
            bathroomsLabel.topAnchor.constraint(equalTo: dropDownBedTypeTextfield.bottomAnchor, constant: space / 4),
            bathroomsLabel.leadingAnchor.constraint(equalTo: bedroomTextField.trailingAnchor, constant: space / 4),
            bathroomsTextField.topAnchor.constraint(equalTo: bathroomsLabel.bottomAnchor),
            bathroomsTextField.leadingAnchor.constraint(equalTo: bedroomTextField.trailingAnchor, constant: space / 6),
            bathroomsTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -space),
            bathroomsTextField.heightAnchor.constraint(equalToConstant: space * 3/2),
            
            accommodateLabel.topAnchor.constraint(equalTo: bathroomsTextField.bottomAnchor, constant: space / 4),
            accommodateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: space),
            accommodatesTextField.topAnchor.constraint(equalTo: accommodateLabel.bottomAnchor),
            accommodatesTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: space),
            accommodatesTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -space),
            accommodatesTextField.heightAnchor.constraint(equalToConstant: space * 3/2),
            
            submitButton.topAnchor.constraint(equalTo: accommodatesTextField.bottomAnchor, constant: space),
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            submitButton.heightAnchor.constraint(equalToConstant: space * 2),
            submitButton.widthAnchor.constraint(equalTo: zipcodeTextField.widthAnchor, multiplier: 0.5)
        ])
    }
    
//MARK:- Methods
    @objc func displayPrice() {
        
        guard let zipcode = zipcodeTextField.text, !zipcode.isEmpty,
              let propertyType = dropDownPropertyTextfield.text, !propertyType.isEmpty,
              let roomTypeText = dropDownRoomTypeTextfield.text, !roomTypeText.isEmpty,
              let bedroomString = bedroomTextField.text, !bedroomString.isEmpty, let bedroomInt = Int(bedroomString),
              let bathroomString = bathroomsTextField.text, !bathroomString.isEmpty,
              let bathroomInt = Int(bathroomString),
              let bedTypesText = dropDownBedTypeTextfield.text, !bedTypesText.isEmpty,
              let accomodationString = accommodatesTextField.text, !accomodationString.isEmpty,
              let accomodates = Int(accomodationString),
              let bedString = bedCountTextField.text, !bedString.isEmpty,
              let bedInt = Int(bedString) else {return}
        
        
        let property = Property(zipcode: zipcode,
                                propertyType: propertyType,
                                roomType: roomTypeText,
                                accommodates: accomodates,
                                bathrooms: bathroomInt,
                                bedrooms: bedroomInt,
                                beds: bedInt,
                                bedType: bedTypesText)
        network.postPropeties(property: property) { pricePredict, _ in
            if let pricePredict = pricePredict {
                DispatchQueue.main.async {
                    let vc = PropertyPriceViewController()
                    vc.pricePredict = pricePredict
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }

    
    @objc func keyboardWillShow(notification: NSNotification) {
        if accommodatesTextField.isEditing {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                if self.view.frame.origin.y == 0 {
                    self.view.frame.origin.y -= keyboardSize.height - 200
                }
            }
        }
    
        dropDownBedTypeTextfield.listWillAppear {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                if self.view.frame.origin.y == 0 {
                    self.view.frame.origin.y -= keyboardSize.height - 280
                }
            }
        }
    }
    
    @objc func keyboardWillHide(notication: NotificationCenter) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

}


extension PropertyViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }

}

