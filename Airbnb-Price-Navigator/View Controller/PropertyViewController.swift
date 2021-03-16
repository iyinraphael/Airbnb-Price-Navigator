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

    
    var prediction: Prediction?
    let propertyViewModel = PropertyViewModel()
    let propertyController = Network()
    
    let roomTypes = ["Entire Property", "Private Room", "Shared Room"]
    let bedTypes = ["Standard Beds",  "Couches", "Pull-out Couches", "Air Mattresses"]
    let propertyTypes = ["House", "Apartment", "Condominium", "Townhouse",
                         "Loft", "Guest Suite", "Bungalow", "Villa", "Other"]
    var roomType: String?
    var bedType: String?
    
    enum BedType: String, Codable {
       case standardBed = "Real Bed"
       case couch = "Couch"
       case futon = "Futon"
       case pullOutCouch = "Pull-Out Sofa"
       case airMattress = "Airbed"
   }
    
    enum RoomType: String, Codable {
            case entireProperty = "Entire home/apt"
            case privateRoom = "Private Room"
            case sharedRoom = "Shared Room"
    }
    
    
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
        submitButton.isEnabled = false
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
            
            bedroomsLabel.topAnchor.constraint(equalTo: dropDownRoomTypeTextfield.bottomAnchor, constant: space / 4),
            bedroomsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: space),
            bedroomTextField.topAnchor.constraint(equalTo: bedroomsLabel.bottomAnchor),
            bedroomTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: space),
            bedroomTextField.widthAnchor.constraint(equalTo: dropDownRoomTypeTextfield.widthAnchor, multiplier: 0.49),
            bedroomTextField.heightAnchor.constraint(equalToConstant: space * 3/2),
            
            bathroomsLabel.topAnchor.constraint(equalTo: dropDownRoomTypeTextfield.bottomAnchor, constant: space / 4),
            bathroomsLabel.leadingAnchor.constraint(equalTo: bedroomTextField.trailingAnchor, constant: space / 4),
            bathroomsTextField.topAnchor.constraint(equalTo: bathroomsLabel.bottomAnchor),
            bathroomsTextField.leadingAnchor.constraint(equalTo: bedroomTextField.trailingAnchor, constant: space / 6),
            bathroomsTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -space),
            bathroomsTextField.heightAnchor.constraint(equalToConstant: space * 3/2),
            
            bedTypesLabel.topAnchor.constraint(equalTo: bathroomsTextField.bottomAnchor, constant: space / 4),
            bedTypesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: space),
            dropDownBedTypeTextfield.topAnchor.constraint(equalTo: bedTypesLabel.bottomAnchor),
            dropDownBedTypeTextfield.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: space),
            dropDownBedTypeTextfield.widthAnchor.constraint(equalTo: dropDownRoomTypeTextfield.widthAnchor, multiplier: 0.49),
            dropDownBedTypeTextfield.heightAnchor.constraint(equalToConstant: space * 3/2),
            
            bedLabel.topAnchor.constraint(equalTo: bathroomsTextField.bottomAnchor, constant: space / 4),
            bedLabel.leadingAnchor.constraint(equalTo: dropDownBedTypeTextfield.trailingAnchor, constant: space / 4),
            bedCountTextField.topAnchor.constraint(equalTo: bedLabel.bottomAnchor),
            bedCountTextField.leadingAnchor.constraint(equalTo: dropDownBedTypeTextfield.trailingAnchor, constant: space / 6),
            bedCountTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -space),
            bedCountTextField.heightAnchor.constraint(equalToConstant: space * 3/2),
            
            accommodateLabel.topAnchor.constraint(equalTo: bedCountTextField.bottomAnchor, constant: space / 4),
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
    @objc func checkTextfield(_ textfield: UITextField) {
        
        if textfield.text?.count == 1{
            if textfield.text?.first == " " {
                textfield.text = " "
                return
            }
        }
        
        guard let zipcode = zipcodeTextField.text, !zipcode.isEmpty,
            let propertyType = dropDownPropertyTextfield.text, !propertyType.isEmpty, textfieldReturn(dropDownPropertyTextfield) == true,
            let roomTypeText = dropDownRoomTypeTextfield.text, !roomTypeText.isEmpty,  textfieldReturn(dropDownRoomTypeTextfield) == true,
            let bedroomString = bedroomTextField.text, !bedroomString.isEmpty,  textfieldReturn(bedroomTextField) == true,
            let bathroomString = bathroomsTextField.text, !bathroomString.isEmpty,  textfieldReturn(bathroomsTextField) == true,
            let bedTypesText = dropDownBedTypeTextfield.text, !bedTypesText.isEmpty, textfieldReturn(dropDownBedTypeTextfield) == true,
            let bedString = bedCountTextField.text,  !bedString.isEmpty, textfieldReturn(bedCountTextField) == true,
            let accomodationString = accommodatesTextField.text, !accomodationString.isEmpty, textfieldReturn(accommodatesTextField) == true
        else
            { submitButton.isEnabled = false
                return
        }
        submitButton.backgroundColor = Appearance.greenGradient
        submitButton.isEnabled = true
    }
    
    @objc func displayPrice() {
        
        guard let zipcode = zipcodeTextField.text, !zipcode.isEmpty,
            let propertyType = dropDownPropertyTextfield.text, !propertyType.isEmpty,
            let roomTypeText = dropDownRoomTypeTextfield.text, !roomTypeText.isEmpty,
            let bedroomString = bedroomTextField.text, !bedroomString.isEmpty,
            let bathroomString = bathroomsTextField.text, !bathroomString.isEmpty,
            let bedTypesText = dropDownBedTypeTextfield.text, !bedTypesText.isEmpty,
            let accomodationString = accommodatesTextField.text, !accomodationString.isEmpty,
            let bedString = bedCountTextField.text, !bedString.isEmpty else {return}
        
        switch roomTypeText {
        case "Entire Property":
            roomType = RoomType.entireProperty.rawValue
        case "Private Room":
            roomType = RoomType.privateRoom.rawValue
        case "Shared Room":
            roomType = RoomType.sharedRoom.rawValue
        default:
            return
        }
        
        switch bedTypesText {
        case "Standard Beds":
            bedType = BedType.standardBed.rawValue
        case "Couches":
            bedType = BedType.couch.rawValue
        case "Pull-out Couches":
            bedType = BedType.pullOutCouch.rawValue
        case "Air Mattresses":
            bedType = BedType.airMattress.rawValue
        default:
            return
        }
        
//
//        if let bedroom = Int(bedroomString), let bathroom = Int(bathroomString), let accomodation = Int(accomodationString), let beds = Int(bedString ){
//
//            let property = Property(zipcode: zipcode, propertyType: propertyType, roomType: roomType, accommodates: accomodation, bathrooms: bathroom, bedrooms: bedroom, beds: beds, bedType: bedType)
//
//            self.propertyController.postPropeties(property: property) { (prediction, error) in
//                       DispatchQueue.main.async {›
//                           let vc = PropertyPriceViewController()
//                           vc.predictions = prediction
//                           let nav = UINavigationController(rootViewController: vc)
//                           nav.modalPresentationStyle = .fullScreen
//                           self.present(nav, animated: true, completion: nil)
//                           self.removeFromParent()
//                       }
//                }
//            }
        }
    
    func textfieldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notication: NotificationCenter) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }

}


extension PropertyViewController: DropDownTextFieldDelegate {
    
    func menuDidAnimate(up: Bool) {
        if dropDownPropertyTextfield.isEnabled == true {
                view.viewWithTag(1)?.isHidden = true
                view.viewWithTag(2)?.isHidden = true
                view.viewWithTag(3)?.isHidden = true
                view.viewWithTag(4)?.isHidden = true
                view.viewWithTag(5)?.isHidden = true
                view.viewWithTag(6)?.isHidden = true
            }
        
        else if dropDownRoomTypeTextfield.isEnabled == true {
            view.viewWithTag(2)?.isHidden = true
            view.viewWithTag(3)?.isHidden = true
            view.viewWithTag(4)?.isHidden = true
        }
        
        else if dropDownBedTypeTextfield.isEnabled == true {
            view.viewWithTag(4)?.isHidden = true
            view.viewWithTag(5)?.isHidden = true
            view.viewWithTag(6)?.isHidden = true
        }
        
        else  {
            view.viewWithTag(1)?.isHidden = false
            view.viewWithTag(2)?.isHidden = false
            view.viewWithTag(3)?.isHidden = false
            view.viewWithTag(4)?.isHidden = false
            view.viewWithTag(5)?.isHidden = false
            view.viewWithTag(6)?.isHidden = false
        }
    }
    
    func optionSelected(option: String) {
        print("option selected: \(option)")
    }
    
    
}

extension PropertyViewController: UITextFieldDelegate {
    

}

