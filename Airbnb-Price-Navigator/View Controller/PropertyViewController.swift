//
//  PropertyViewController.swift
//  Airbnb-Price-Navigator
//
//  Created by Iyin Raphael on 9/14/19.
//  Copyright © 2019 Iyin Raphael. All rights reserved.
//

import UIKit

class PropertyViewController: PropertyBaseNavViewController {
    
    //MARK: - Properties
    var stackview: UIStackView!
    
    var bedroomTextField: UITextField!
    var bathroomsTextField: UITextField!
    var accommodatesTextField: UITextField!
    var zipcodeTextField: UITextField!
    
    var bathroomsLabel: UILabel!
    var submitButton: UIButton!
    
   
    var dropDownPropertyTextfield: DropDownTextField!
    var dropDownRoomTypeTextfield: DropDownTextField!
    var dropDownBedTypeTextfield: DropDownTextField!

    var property: Property?
    var prediction: Prediction?
    let propertyController = PropertyController()
   
    //MARK:- UI SETUP
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stackview = UIStackView()
        view.addSubview(stackview)
        
        stackview.axis = .vertical
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.distribution = .fillEqually
        stackview.spacing = 50.0
        stackview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
        stackview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40.0).isActive = true
        stackview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40.0).isActive = true
       
        addZipcodeTextField()
        addDropDownPropertyTextfield()
        addDropDownRoomTypeTextfield()
        addBedAndBathTextfield()
        addDropdownBedTypeTextfield()
        addAccomodationTexField()
        

        submitButton = UIButton()
        view.addSubview(submitButton)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.tag = 5
        submitButton.addTarget(self, action: #selector(displayPrice), for: .touchUpInside)
        submitButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 550).isActive = true
        submitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        submitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        submitButton.setTitle("Submit", for: .normal)
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.backgroundColor = .lightGray

    }
    
    private func addZipcodeTextField() {
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
        
        let zipcodeStackView = UIStackView()
        stackview.addArrangedSubview(zipcodeStackView)
        zipcodeStackView.axis = .vertical
        
        let _: UILabel = {
            let zipcodeLabel = UILabel()
            zipcodeLabel.text = "Zip Code"
            zipcodeLabel.font = .systemFont(ofSize: 12.0, weight: .light)
            zipcodeStackView.addArrangedSubview(zipcodeLabel)
            return zipcodeLabel
        }()
        
        let _: UITextField = {
            zipcodeTextField = UITextField(frame: .zero)
            zipcodeTextField.translatesAutoresizingMaskIntoConstraints = false
            zipcodeTextField.frame.size.height = 40.0
            zipcodeTextField.contentMode = .redraw
            zipcodeTextField.layer.borderWidth = 0.3
            zipcodeTextField.layer.borderColor = UIColor.gray.cgColor
            zipcodeTextField.font = .systemFont(ofSize: 12.0, weight: .light)
            zipcodeTextField.placeholder = "90210"
            zipcodeStackView.addArrangedSubview(zipcodeTextField)
            return zipcodeTextField
        }()
    }
    
    private func addDropDownPropertyTextfield() {
        let lm = view.layoutMargins
        let height: CGFloat = 30.0
        let dropDownFrame = CGRect(x: lm.left, y: lm.top + 60, width: 296, height: height)
        
        let propertyTypeStackView = UIStackView()
        view.addSubview(propertyTypeStackView)
        propertyTypeStackView.translatesAutoresizingMaskIntoConstraints = false
        propertyTypeStackView.axis = .vertical
        propertyTypeStackView.topAnchor.constraint(equalTo: stackview.bottomAnchor, constant: 10).isActive = true
        propertyTypeStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40.0).isActive = true
        propertyTypeStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40.0).isActive = true
        
        let _: UILabel = {
            let propertyLabel = UILabel()
            propertyLabel.text = "Property Type"
            propertyLabel.font = .systemFont(ofSize: 12.0, weight: .light)
            propertyTypeStackView.addArrangedSubview(propertyLabel)
            return propertyLabel
        }()
        
        let propertyTypes = ["House", "Apartment", "Condominium", "Townhouse", "Loft", "Guest Suite", "Bungalow", "Villa", "Other"]
        dropDownPropertyTextfield = DropDownTextField(frame: dropDownFrame, title: "House", options: propertyTypes)
        dropDownPropertyTextfield.delegate = self
        propertyTypeStackView.addArrangedSubview(dropDownPropertyTextfield)
        
    }
    
    private func addDropDownRoomTypeTextfield() {
        let lm = view.layoutMargins
        let height: CGFloat = 30.0
        let dropDownFrame = CGRect(x: lm.left, y: lm.top + 60, width: 296, height: height)
        
        let roomTypeStackView = UIStackView()
        view.addSubview(roomTypeStackView)
        roomTypeStackView.axis = .vertical
        roomTypeStackView.tag = 1
        roomTypeStackView.translatesAutoresizingMaskIntoConstraints = false
        roomTypeStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 290).isActive = true
        roomTypeStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40.0).isActive = true
        roomTypeStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40.0).isActive = true
        
        let _: UILabel = {
            let roomTypeLabel = UILabel()
            roomTypeLabel.text = "Room Type"
            roomTypeLabel.font = .systemFont(ofSize: 12.0, weight: .light)
            roomTypeStackView.addArrangedSubview(roomTypeLabel)
            return roomTypeLabel
        }()
        
        let roomTypes = ["Entire Property", "Private Room", "Shared Room"]
        dropDownRoomTypeTextfield = DropDownTextField(frame: dropDownFrame, title: "Entire Property", options: roomTypes)
        dropDownRoomTypeTextfield.delegate = self
        roomTypeStackView.addArrangedSubview(dropDownRoomTypeTextfield)
    }
    
    private func addBedAndBathTextfield() {
        let bedAndBathStackView = UIStackView()
        view.addSubview(bedAndBathStackView)
        bedAndBathStackView.translatesAutoresizingMaskIntoConstraints = false
        bedAndBathStackView.axis = .horizontal
        bedAndBathStackView.distribution = .fillEqually
        bedAndBathStackView.spacing = 5.0
        bedAndBathStackView.axis = .vertical
        bedAndBathStackView.tag = 2
        bedAndBathStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 340).isActive = true
        bedAndBathStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        bedAndBathStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        
        let bedroomsStackView = UIStackView()
        let bathroomsStackView = UIStackView()
        bedroomsStackView.axis = .vertical
        bathroomsStackView.axis = .vertical
        bedAndBathStackView.addArrangedSubview(bedroomsStackView)
        bedAndBathStackView.addArrangedSubview(bathroomsStackView)
        bedAndBathStackView.axis = .horizontal
        
        let _: UILabel = {
            let bedroomsLabel = UILabel()
            bedroomsLabel.text = "Bedrooms"
            bedroomsLabel.font = .systemFont(ofSize: 12.0, weight: .light)
            bedroomsStackView.addArrangedSubview(bedroomsLabel)
            return bedroomsLabel
        }()
       
        let _: UILabel = {
            let bathroomsLabel = UILabel()
            bathroomsLabel.text = "Bathrooms"
            bathroomsLabel.font = .systemFont(ofSize: 12.0, weight: .light)
            bathroomsStackView.addArrangedSubview(bathroomsLabel)
            return bathroomsLabel
        }()
        
        bedroomTextField = UITextField()
        bedroomTextField.layer.borderWidth = 0.3
        bedroomTextField.layer.borderColor = UIColor.gray.cgColor
        bedroomTextField.font = .systemFont(ofSize: 14.0, weight: .light)
        bedroomTextField.placeholder = "0"
        bedroomsStackView.addArrangedSubview(bedroomTextField)
        
        bathroomsTextField = UITextField()
        bathroomsTextField.layer.borderWidth = 0.3
        bathroomsTextField.layer.borderColor = UIColor.gray.cgColor
        bathroomsTextField.font = .systemFont(ofSize: 14.0, weight: .light)
        bathroomsTextField.placeholder = "0"
        bathroomsStackView.addArrangedSubview(bathroomsTextField)
    }
    
    private func addDropdownBedTypeTextfield() {
        let lm = view.layoutMargins
        let height: CGFloat = 30.0
        let dropDownFrame = CGRect(x: lm.left, y: lm.top + 60, width: 296, height: height)
        
        let bedTypesStackView = UIStackView()
        view.addSubview(bedTypesStackView)
        bedTypesStackView.translatesAutoresizingMaskIntoConstraints = false
        bedTypesStackView.axis = .vertical
        bedTypesStackView.tag = 3
        bedTypesStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 390).isActive = true
        bedTypesStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        bedTypesStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        
        let _: UILabel = {
            let bedTypesLabel = UILabel()
            bedTypesLabel.text = "Bed Types"
            bedTypesLabel.font = .systemFont(ofSize: 12.0, weight: .light)
            bedTypesStackView.addArrangedSubview(bedTypesLabel)
            return bedTypesLabel
        }()
        
        let bedTypes = ["Standard Beds", "Couches", "Futons", "Pull-out Couches", "Air Mattresses"]
        dropDownBedTypeTextfield = DropDownTextField(frame: dropDownFrame, title: "Standard Bed", options: bedTypes)
        dropDownBedTypeTextfield.delegate = self
        bedTypesStackView.addArrangedSubview(dropDownBedTypeTextfield)
    }
    
    private func addAccomodationTexField() {
        let accommodatStackView = UIStackView()
        view.addSubview(accommodatStackView)
        accommodatStackView.translatesAutoresizingMaskIntoConstraints = false
        accommodatStackView.axis = .vertical
        accommodatStackView.tag = 4
        accommodatStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 440).isActive = true
        accommodatStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        accommodatStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        
        let _: UILabel = {
            let accommodateLabel = UILabel()
            accommodateLabel.text = "Accomodates how many guest?"
            accommodateLabel.font = .systemFont(ofSize: 12.0, weight: .light)
            accommodatStackView.addArrangedSubview(accommodateLabel)
            return accommodateLabel
        }()
    
        
        accommodatesTextField = UITextField(frame: .zero)
        accommodatesTextField.translatesAutoresizingMaskIntoConstraints = false
        accommodatesTextField.frame.size.height = 40
        accommodatesTextField.contentMode = .redraw
        accommodatesTextField.font = .systemFont(ofSize: 14.0, weight: .light)
        accommodatesTextField.placeholder = "0"
        accommodatesTextField.layer.borderWidth = 0.3
        accommodatesTextField.layer.borderColor = UIColor.gray.cgColor
        accommodatStackView.addArrangedSubview(accommodatesTextField)
    }
    
    @objc func displayPrice() {
        guard let zipcode = zipcodeTextField.text,
        let propertyType = dropDownPropertyTextfield.textField.text,
        let roomType = dropDownRoomTypeTextfield.textField.text,
        let bedroomString = bedroomTextField.text,
        let bathroomString = bathroomsTextField.text,
        let bedTypes = dropDownBedTypeTextfield.textField.text,
        let accomodationString = accommodatesTextField.text else {return}
        
        if let bedroom = Int(bedroomString), let bathroom = Int(bathroomString), let accomodation = Int(accomodationString) {
            property = Property(zipCode: zipcode, propertyType: propertyType, roomType: roomType, accomodates: accomodation, bathrooms: bathroom, bedrooms: bedroom, beds: 2 , bedType: bedTypes)
        }
        guard let property = property else {return}
        
        DispatchQueue.main.async {
            self.propertyController.postPropeties(property: property) { (prediction, error) in
                self.prediction = prediction
                let vc = PropertyPriceViewController()
                self.present(vc, animated: true, completion: nil)
            }
        }
      
    }
   
}


extension PropertyViewController: DropDownTextFieldDelegate {
    
    func menuDidAnimate(up: Bool) {
        
        if dropDownPropertyTextfield.isDroppedDown == true {
                 view.viewWithTag(1)?.isHidden = true
                 view.viewWithTag(2)?.isHidden = true
                 view.viewWithTag(3)?.isHidden = true
                view.viewWithTag(4)?.isHidden = true
            }
        
        else if dropDownRoomTypeTextfield.isDroppedDown == true {
            view.viewWithTag(2)?.isHidden = true
            view.viewWithTag(3)?.isHidden = true
            view.viewWithTag(4)?.isHidden = true
        }
        
        else if dropDownBedTypeTextfield.isDroppedDown == true {
            view.viewWithTag(4)?.isHidden = true
            view.viewWithTag(5)?.isHidden = true
        }
        
        else  {
            view.viewWithTag(1)?.isHidden = false
            view.viewWithTag(2)?.isHidden = false
            view.viewWithTag(3)?.isHidden = false
            view.viewWithTag(4)?.isHidden = false
            view.viewWithTag(5)?.isHidden = false
        }
    }
    
    func optionSelected(option: String) {
        print("option selected: \(option)")
    }
    
    
}
