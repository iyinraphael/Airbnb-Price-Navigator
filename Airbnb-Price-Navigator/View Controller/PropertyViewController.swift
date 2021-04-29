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
    

    //MARK: - Outlets
    private var bedroomSlider: UISlider!
    private var bathroomsSlider: UISlider!
    private var accommodateSlider: UISlider!
    private var bedCountSlider: UISlider!
    private var backgroundView: UIImageView!
    private var submitButton: UIButton!
    private var zipcodeTextField: UITextField!
    private var numberOfBedsLabel: UILabel!
    private var numberOfBedroomLabel: UILabel!
    private var numberOfBathroomLabel: UILabel!
    private var numberOfaccomodateLabel: UILabel!
    private var dropDownPropertyTextfield: DropDown!
    private var dropDownRoomTypeTextfield: DropDown!
    private var dropDownBedTypeTextfield: DropDown!
    
    // MARK: - Properties
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
        numberOfBedsLabel = UILabel()
        numberOfBedroomLabel = UILabel()
        numberOfBathroomLabel = UILabel()
        numberOfaccomodateLabel = UILabel()
        addLabel(bedroomsLabel, with: "No. of Bedrooms")
        addLabel(bathroomsLabel, with: "No of Bathrooms")
        addLabel(bedLabel, with: "No. of Beds")
        addLabel(accommodateLabel, with: "Accomodates how many guests?")
        addLabel(numberOfBedsLabel, with: "0")
        addLabel(numberOfBedroomLabel, with: "0")
        addLabel(numberOfBathroomLabel, with: "0")
        addLabel(numberOfaccomodateLabel, with: "0")
        
        bedCountSlider = UISlider()
        bedroomSlider = UISlider()
        bathroomsSlider = UISlider()
        accommodateSlider = UISlider()
        addSlider(bedCountSlider, from: 0, to: 10)
        addSlider(bedroomSlider, from: 0, to: 15)
        addSlider(bathroomsSlider, from: 0, to: 10)
        addSlider(accommodateSlider, from: 0, to: 30)
        bedCountSlider.addTarget(self, action: #selector(bedsCountSliderChanged), for: .valueChanged)
        bedroomSlider.addTarget(self, action: #selector(numberOfBedroomSliderChanged), for: .valueChanged)
        bathroomsSlider.addTarget(self, action: #selector(numberOfBathroomSliderChanged), for: .valueChanged)
        accommodateSlider.addTarget(self, action: #selector(numberOfaccomodateSliderChanged), for: .valueChanged)
        
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
        view.addSubview(submitButton)

        
        let space: CGFloat = 20
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: space),
            headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: space),
            headerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -space),
            
            zipcodeTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 1/3 - space),
            zipcodeTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: space),
            zipcodeTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -space),
            zipcodeTextField.heightAnchor.constraint(equalToConstant: space * 2),

            dropDownPropertyTextfield.topAnchor.constraint(equalTo: zipcodeTextField.bottomAnchor, constant: space / 2),
            dropDownPropertyTextfield.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: space),
            dropDownPropertyTextfield.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -space),
            dropDownPropertyTextfield.heightAnchor.constraint(equalToConstant: space * 2),

            dropDownRoomTypeTextfield.topAnchor.constraint(equalTo:dropDownPropertyTextfield.bottomAnchor, constant: space / 2),
            dropDownRoomTypeTextfield.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: space),
            dropDownRoomTypeTextfield.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -space),
            dropDownRoomTypeTextfield.heightAnchor.constraint(equalToConstant: space * 2),

            dropDownBedTypeTextfield.topAnchor.constraint(equalTo: dropDownRoomTypeTextfield.bottomAnchor, constant: space / 2),
            dropDownBedTypeTextfield.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: space),
            dropDownBedTypeTextfield.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -space),
            dropDownBedTypeTextfield.heightAnchor.constraint(equalToConstant: space * 2),
            
            bedLabel.topAnchor.constraint(equalTo: dropDownBedTypeTextfield.bottomAnchor, constant: space / 2),
            bedLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: space),
            numberOfBedsLabel.topAnchor.constraint(equalTo: bedLabel.topAnchor),
            numberOfBedsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -space),
            bedCountSlider.topAnchor.constraint(equalTo: bedLabel.bottomAnchor),
            bedCountSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: space),
            bedCountSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -space),
            
            bedroomsLabel.topAnchor.constraint(equalTo: bedCountSlider.bottomAnchor, constant: space / 2),
            bedroomsLabel.leadingAnchor.constraint(equalTo: bedCountSlider.leadingAnchor),
            numberOfBedroomLabel.topAnchor.constraint(equalTo: bedroomsLabel.topAnchor),
            numberOfBedroomLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -space),
            bedroomSlider.topAnchor.constraint(equalTo: bedroomsLabel.bottomAnchor),
            bedroomSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: space),
            bedroomSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -space),

            bathroomsLabel.topAnchor.constraint(equalTo: bedroomSlider.bottomAnchor, constant: space / 2),
            bathroomsLabel.leadingAnchor.constraint(equalTo: bedroomsLabel.leadingAnchor),
            numberOfBathroomLabel.topAnchor.constraint(equalTo: bathroomsLabel.topAnchor),
            numberOfBathroomLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -space),
            bathroomsSlider.topAnchor.constraint(equalTo: bathroomsLabel.bottomAnchor),
            bathroomsSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: space),
            bathroomsSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -space),

            accommodateLabel.topAnchor.constraint(equalTo: bathroomsSlider.bottomAnchor, constant: space / 2),
            accommodateLabel.leadingAnchor.constraint(equalTo: bathroomsSlider.leadingAnchor),
            numberOfaccomodateLabel.topAnchor.constraint(equalTo: accommodateLabel.topAnchor),
            numberOfaccomodateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -space),
            accommodateSlider.topAnchor.constraint(equalTo: accommodateLabel.bottomAnchor),
            accommodateSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: space),
            accommodateSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -space),
            
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            submitButton.topAnchor.constraint(equalTo: accommodateSlider.bottomAnchor, constant: space),
            submitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: space),
            submitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -space)
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
        
//        guard let zipcode = zipcodeTextField.text, !zipcode.isEmpty,
//              let propertyType = dropDownPropertyTextfield.text, !propertyType.isEmpty,
//              let roomTypeText = dropDownRoomTypeTextfield.text, !roomTypeText.isEmpty,
//              let bedroomString = bedroomS.text, !bedroomString.isEmpty, let bedroomInt = Int(bedroomString),
//              let bathroomString = bathroomsTextField.text, !bathroomString.isEmpty,
//              let bathroomInt = Int(bathroomString),
//              let bedTypesText = dropDownBedTypeTextfield.text, !bedTypesText.isEmpty,
//              let accomodationString = accommodatesTextField.text, !accomodationString.isEmpty,
//              let accomodates = Int(accomodationString),
//              let bedString = bedCountTextField.text, !bedString.isEmpty,
//              let bedInt = Int(bedString) else {return}
//
//
//        let property = Property(zipcode: zipcode, propertyType: propertyType, roomType: roomTypeText,
//                                accommodates: accomodates, bathrooms: bathroomInt, bedrooms: bedroomInt,
//                                beds: bedInt, bedType: bedTypesText)
//        viewModel.predictPrice(property: property)
        
        present(PropertyPriceViewController(), animated: true)
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
        textField.defaultTextAttributes = attributedTextForTextField()
        textField.attributedPlaceholder = attributedText(for: placholder)
        textField.delegate = self
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = radius
        textField.textColor = .black
        textField.layer.borderColor = Appearance.textFieldBorderColor
        textField.placeholder = placholder
        view.addSubview(textField)
    }
    
    private func addDropdownTextField(_ textField: DropDown, with options: [String], _ placeholder: String) {
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.defaultTextAttributes = attributedTextForTextField()
        textField.attributedPlaceholder = attributedText(for: placeholder)
        textField.textColor = .black
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
    
    private func addSlider(_ slider: UISlider, from minValue: Float, to maxValue: Float) {
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumValue  = minValue
        slider.maximumValue = maxValue
        slider.thumbTintColor = Appearance.greenGradient
        slider.minimumTrackTintColor = Appearance.greenGradient
        view.addSubview(slider)
    }
    
    private func applyGradient(with colors: [CGColor]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.frame = backgroundView.bounds
        gradientLayer.locations = [0.6, 1]
        backgroundView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func attributedTextForTextField() -> [NSAttributedString.Key : Any]{
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .left
        paragraph.firstLineHeadIndent = 5.0
        let attributedText =  [NSAttributedString.Key.paragraphStyle : paragraph, .font : Appearance.labelFont!]
        return attributedText
    }
    
    private func attributedText(for placeholder: String) -> NSAttributedString {
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .left
        paragraph.firstLineHeadIndent = 5.0
        let attributedText =  [NSAttributedString.Key.paragraphStyle : paragraph, .font : Appearance.labelFont!]
        return NSAttributedString(string: placeholder, attributes: attributedText)
    }
    
    @objc func bedsCountSliderChanged(_ sender: UISlider) {
        numberOfBedsLabel.text = "\(Int(sender.value))"
    }
    
    @objc func numberOfBedroomSliderChanged(_ sender: UISlider) {
        numberOfBedroomLabel.text = "\(Int(sender.value))"
    }
    
    @objc func numberOfBathroomSliderChanged(_ sender: UISlider) {
        numberOfBathroomLabel.text = "\(Int(sender.value))"
    }
    
    @objc func numberOfaccomodateSliderChanged( _ sender: UISlider) {
        numberOfaccomodateLabel.text = "\(Int(sender.value))"
    }
}

    // MARK: -  UITextFieldDelegate
extension PropertyViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }

}

