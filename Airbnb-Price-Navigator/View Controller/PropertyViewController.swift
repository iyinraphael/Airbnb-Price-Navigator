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
    var dropDownBedTypeTextfield: DropDownTextField!
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
        
        let lm = view.layoutMargins
        let height: CGFloat = 40.0
        let dropDownFrame = CGRect(x: lm.left, y: lm.top + 60, width: 296, height: height)
        
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
        zipcodeTextField.font = Appearance.textFieldFont
        zipcodeTextField.placeholder = "90210"
        
        let propertyLabel = UILabel()
        propertyLabel.translatesAutoresizingMaskIntoConstraints = false
        propertyLabel.text = "Property Type"
        propertyLabel.font = Appearance.labelFont
        dropDownPropertyTextfield = DropDown(frame: .zero)
        dropDownPropertyTextfield.optionArray = propertyTypes
        dropDownPropertyTextfield.translatesAutoresizingMaskIntoConstraints = false
        dropDownPropertyTextfield.delegate = self
        dropDownPropertyTextfield.font = Appearance.textFieldFont
        dropDownPropertyTextfield.layer.borderColor = Appearance.textFieldBorderColor
        
        let roomTypeLabel = UILabel()
        roomTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        roomTypeLabel.text = "Room Type"
        roomTypeLabel.font = Appearance.labelFont
        dropDownRoomTypeTextfield = DropDown(frame: .zero)
        dropDownRoomTypeTextfield.optionArray = roomTypes
        dropDownRoomTypeTextfield.translatesAutoresizingMaskIntoConstraints = false
        dropDownRoomTypeTextfield.font = Appearance.textFieldFont
        dropDownRoomTypeTextfield.delegate = self
        
        let bedroomsLabel = UILabel()
        bedroomsLabel.text = "Bedrooms"
        bedroomsLabel.font = Appearance.labelFont
        bedroomTextField = UITextField()
        bedroomTextField.layer.borderWidth = 1.0
        bedroomTextField.font = Appearance.textFieldFont
        bedroomTextField.layer.borderColor = Appearance.textFieldBorderColor
        bedroomTextField.placeholder = " 0"
        
        let bathroomsLabel = UILabel()
        bathroomsLabel.text = "Bathrooms"
        bathroomsLabel.font = Appearance.labelFont
        bathroomsTextField = UITextField()
        bathroomsTextField.layer.borderWidth = 1.0
        bathroomsTextField.font = Appearance.textFieldFont
        bathroomsTextField.layer.borderColor = Appearance.textFieldBorderColor
        bathroomsTextField.placeholder = " 0"
        
        let bedTypesLabel = UILabel()
        bedTypesLabel.text = "Bed Types"
        bedTypesLabel.font = Appearance.labelFont
        dropDownBedTypeTextfield = DropDownTextField(frame: dropDownFrame, title: "Standard Bed", options: bedTypes)
        dropDownBedTypeTextfield.textField.font = Appearance.textFieldFont
        dropDownBedTypeTextfield.delegate = self
        
        let bedLabel = UILabel()
        bedLabel.text = "Bed"
        bedLabel.font = Appearance.labelFont
        bedCountTextField = UITextField()
        bedCountTextField.layer.borderWidth = 1.0
        bedCountTextField.font = Appearance.textFieldFont
        bedCountTextField.layer.borderColor = Appearance.textFieldBorderColor
        bedCountTextField.placeholder = "0"
        
        let accommodateLabel = UILabel()
        accommodateLabel.text = "Accomodates how many guest?"
        accommodateLabel.font = Appearance.labelFont
        accommodatesTextField = UITextField(frame: .zero)
        accommodatesTextField.placeholder = "0"
        accommodatesTextField.layer.borderWidth = 1.0
        accommodatesTextField.font = Appearance.textFieldFont
        accommodatesTextField.layer.borderColor = Appearance.textFieldBorderColor

        
        view.addSubview(headerLabel)
        view.addSubview(zipcodeLabel)
        view.addSubview(zipcodeTextField)
        view.addSubview(propertyLabel)
        view.addSubview(dropDownPropertyTextfield)
        view.addSubview(roomTypeLabel)
        view.sendSubviewToBack(roomTypeLabel)
        view.addSubview(dropDownRoomTypeTextfield)
        view.sendSubviewToBack(dropDownRoomTypeTextfield)
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
        submitButton.backgroundColor = .lightGray
        
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20),
            headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            headerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            zipcodeLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 40),
            zipcodeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            zipcodeTextField.topAnchor.constraint(equalTo: zipcodeLabel.bottomAnchor),
            zipcodeTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            zipcodeTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            zipcodeTextField.heightAnchor.constraint(equalToConstant: 40),
            
            propertyLabel.topAnchor.constraint(equalTo: zipcodeTextField.bottomAnchor, constant: 10),
            propertyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            dropDownPropertyTextfield.topAnchor.constraint(equalTo: propertyLabel.bottomAnchor),
            dropDownPropertyTextfield.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            dropDownPropertyTextfield.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//            dropDownPropertyTextfield.heightAnchor.constraint(equalToConstant: 40),
            
            roomTypeLabel.topAnchor.constraint(equalTo: dropDownPropertyTextfield.bottomAnchor, constant: 10),
            roomTypeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            dropDownRoomTypeTextfield.topAnchor.constraint(equalTo: roomTypeLabel.bottomAnchor),
            dropDownRoomTypeTextfield.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            dropDownRoomTypeTextfield.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
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
            let bedTypesText = dropDownBedTypeTextfield.textField.text, !bedTypesText.isEmpty, textfieldReturn(dropDownBedTypeTextfield.textField) == true,
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
            let bedTypesText = dropDownBedTypeTextfield.textField.text, !bedTypesText.isEmpty,
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
        
        else if dropDownBedTypeTextfield.isDroppedDown == true {
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

