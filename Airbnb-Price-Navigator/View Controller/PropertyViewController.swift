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
    private var backgroundView: UIImageView!
    private var bedroomTextField: UITextField!
    private var bathroomsTextField: UITextField!
    @objc dynamic var accommodatesTextField: UITextField!
    private var zipcodeTextField: UITextField!
    private var bedCountTextField: UITextField!
    private var dropDownPropertyTextfield: DropDown!
    private var dropDownRoomTypeTextfield: DropDown!
    private var dropDownBedTypeTextfield: DropDown!
    private var submitButton: UIButton!
    
    private let roomTypes = ["Entire home/apt", "Private Room", "Shared Room"]
    private let bedTypes = ["Real Bed",  "Couch", "Futon", "Pull-Out Sofa", "Airbed"]
    private let propertyTypes = ["House", "Apartment", "Condominium", "Townhouse",
                         "Loft", "Guest Suite", "Bungalow", "Villa", "Other"]
    private var roomType: String?
    private var bedType: String?
    private var viewModel = ViewModel()
    let radius: CGFloat = 5
    
//MARK:- UI SETUP
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardDidHideNotification,
                                               object: nil)
       

        let height = view.frame.height * 1/4
        let width = view.frame.width
        backgroundView = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        backgroundView.image = UIImage(named: "backgroundImage")
        applyGradient(with: [Appearance.blackGradient.cgColor, UIColor.white.cgColor])
        
        let headerLabel = UILabel()
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.text = "Find out the value of your property!"
        headerLabel.numberOfLines = 0
        headerLabel.textAlignment = .center
        headerLabel.font = Appearance.headerFont
        
        zipcodeTextField = UITextField()
        dropDownPropertyTextfield = DropDown()
        dropDownRoomTypeTextfield = DropDown()
        dropDownBedTypeTextfield = DropDown()
        addTextField(zipcodeTextField, with: "Zip Code")
        addDropdownTextField(dropDownPropertyTextfield, with: propertyTypes, "Property Type")
        addDropdownTextField(dropDownRoomTypeTextfield, with: roomTypes, "Room Type")
        addDropdownTextField(dropDownBedTypeTextfield, with: bedTypes, "Bed Type")
        
        let bedroomsLabel = UILabel()
        let bathroomsLabel = UILabel()
        let bedLabel = UILabel()
        let accommodateLabel = UILabel()
        addLabel(bedroomsLabel, with: "No. of Bedrooms")
        addLabel(bathroomsLabel, with: "No of Bathrooms")
        addLabel(bedLabel, with: "No. of Beds")
        addLabel(accommodateLabel, with: "Accomodates how many guests")
        
        submitButton = UIButton()
        submitButton.isEnabled = true
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.tag = 6
        submitButton.addTarget(self, action: #selector(displayPrice), for: .touchUpInside)
        submitButton.setTitle("Submit", for: .normal)
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.backgroundColor = Appearance.greenGradient
        submitButton.layer.masksToBounds = true
        submitButton.layer.cornerRadius = radius
        
        view.addSubview(backgroundView)
        view.addSubview(headerLabel)

        
        let space: CGFloat = 20
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: space),
            headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: space),
            headerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -space),
            
            zipcodeTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 1/3),
            zipcodeTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: space),
            zipcodeTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -space),
            zipcodeTextField.heightAnchor.constraint(equalToConstant: space * 3/2),

            dropDownPropertyTextfield.topAnchor.constraint(equalTo: zipcodeTextField.bottomAnchor, constant: space / 2),
            dropDownPropertyTextfield.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: space),
            dropDownPropertyTextfield.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -space),
            dropDownPropertyTextfield.heightAnchor.constraint(equalToConstant: space * 3/2),

            dropDownRoomTypeTextfield.topAnchor.constraint(equalTo:dropDownPropertyTextfield.bottomAnchor, constant: space / 2),
            dropDownRoomTypeTextfield.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: space),
            dropDownRoomTypeTextfield.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -space),
            dropDownRoomTypeTextfield.heightAnchor.constraint(equalToConstant: space * 3/2),

            dropDownBedTypeTextfield.topAnchor.constraint(equalTo: dropDownRoomTypeTextfield.bottomAnchor, constant: space / 2),
            dropDownBedTypeTextfield.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: space),
            dropDownBedTypeTextfield.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -space),
            dropDownBedTypeTextfield.heightAnchor.constraint(equalToConstant: space * 3/2)
        ])
        
        viewModel.didFinish = { [weak self] in
            if let self = self {
                DispatchQueue.main.async {
                    let vc = PropertyPriceViewController()
                    vc.pricePredict = self.viewModel.price
                    self.present(vc, animated: true)
                }
            }
            
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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
        
        
        let property = Property(zipcode: zipcode, propertyType: propertyType, roomType: roomTypeText,
                                accommodates: accomodates, bathrooms: bathroomInt, bedrooms: bedroomInt,
                                beds: bedInt, bedType: bedTypesText)
        viewModel.predictPrice(property: property)
    }

    
    @objc func keyboardWillShow(notification: NSNotification) {
        dropDownBedTypeTextfield.listWillAppear {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                if self.view.frame.origin.y == 0 {
                    self.view.frame.origin.y -= keyboardSize.height - 300
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
    
    
    private func addLabel(_ label: UILabel, with title: String) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = title
        label.font = Appearance.labelFont
        view.addSubview(label)
    }
    
    private func addTextField( _ textField: UITextField, with placholder: String) {
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.attributedText = attributedTextForTextField(placholder)
        textField.delegate = self
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = radius
        textField.font = Appearance.textFieldFont
        textField.layer.borderColor = Appearance.textFieldBorderColor
        textField.placeholder = placholder
        view.addSubview(textField)
    }
    
    private func addDropdownTextField(_ textField: DropDown, with options: [String], _ placeholder: String) {
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.attributedText = attributedTextForTextField(placeholder)
        textField.optionArray = options
        textField.checkMarkEnabled = false
        textField.isSearchEnable = false
        textField.selectedRowColor = Appearance.greenGradient
        textField.delegate = self
        textField.borderWidth = 1.0
        textField.layer.borderColor = Appearance.textFieldBorderColor
        textField.layer.cornerRadius = radius
        view.addSubview(textField)
        
    }
    
    private func applyGradient(with colors: [CGColor]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.frame = backgroundView.bounds
        gradientLayer.locations = [0.6, 1]
        backgroundView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func attributedTextForTextField(_ placeholder: String) -> NSAttributedString {
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .left
        paragraph.firstLineHeadIndent = 5.0
        let attributedText: [NSAttributedString.Key : Any] =  [.paragraphStyle : paragraph,
                                                               .font : Appearance.textFieldFont!]
        return NSAttributedString(string: placeholder, attributes: attributedText)
    }

}

    // MARK: -  UITextFieldDelegate
extension PropertyViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }

}

