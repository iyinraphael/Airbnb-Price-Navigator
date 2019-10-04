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
    var zipcodeStackView: UIStackView!
    var roomTypeStackView: UIStackView!
    var propertyTypeStackView: UIStackView!
    var bedroomsStackView: UIStackView!
    var bathroomsStackView:  UIStackView!
    var bedAndBathStackView: UIStackView!
    var bedTypesStackView: UIStackView!
    var accommodatStackView: UIStackView!

    var bedroomTextField: UITextField!
    var bathroomsTextField: UITextField!
    var accommodatesTextField: UITextField!
    var zipcodeTextField: UITextField!
    
    var propertyLabel: UILabel!
    var roomTypeLabel: UILabel!
    var bedroomsLabel: UILabel!
    var bathroomsLabel: UILabel!
    var bedTypesLabel: UILabel!
    var accommodateLabel: UILabel!
    
    var submitButton: UIButton!
    
   
    var dropDownPropertyTextfield: DropDownTextField!
    var dropDownRoomTypeTextfield: DropDownTextField!
    var dropDownBedTypeTextfield: DropDownTextField!
    private var flavourOptions = ["Chocolate", "Vanilla", "Strawberry", "Banana", "Lime"]

    var property: Property?
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
        
        let _: UITextField = {
            zipcodeTextField = UITextField()
            zipcodeTextField.borderStyle = .line
            zipcodeTextField.placeholder = "90210"
            zipcodeStackView.addArrangedSubview(zipcodeTextField)
            
            return zipcodeTextField
        }()
    }
    
    private func addBedAndBathTextfield() {
        bedAndBathStackView = UIStackView()
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
        
        bedroomsStackView = UIStackView()
        bathroomsStackView = UIStackView()
        bedAndBathStackView.addArrangedSubview(bedroomsStackView)
        bedAndBathStackView.addArrangedSubview(bathroomsStackView)
        
        bedAndBathStackView.axis = .horizontal
        
        bedroomsLabel = UILabel()
        bedroomsLabel.text = "Bedrooms"
        bedroomsLabel.font = .boldSystemFont(ofSize: 12)
        
        bedroomTextField = UITextField()
        bedroomTextField.borderStyle = .line
        bedroomTextField.placeholder = "0"
        
        bedroomsStackView.addArrangedSubview(bedroomsLabel)
        bedroomsStackView.addArrangedSubview(bedroomTextField)
        bedroomsStackView.axis = .vertical
        

        
        bedroomTextField = UITextField()
        bedroomTextField.borderStyle = .line
        bedroomTextField.placeholder = "0"
        
        
        bathroomsLabel = UILabel()
        bathroomsLabel.text = "Bathrooms"
        bathroomsLabel.font = .boldSystemFont(ofSize: 12)
        
        bathroomsTextField = UITextField()
        bathroomsTextField.borderStyle = .line
        bathroomsTextField.placeholder = "0"
        
        bathroomsStackView.addArrangedSubview(bathroomsLabel)
        bathroomsStackView.addArrangedSubview(bathroomsTextField)
        bathroomsStackView.axis = .vertical
      
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
        
        roomTypeLabel = UILabel()
        roomTypeLabel.text = "Room Type"
        roomTypeLabel.font = .boldSystemFont(ofSize: 12.0)
    
        dropDownRoomTypeTextfield = DropDownTextField(frame: dropDownFrame, title: "Entire Property", options: flavourOptions)
        dropDownRoomTypeTextfield.delegate = self
        
        roomTypeStackView = UIStackView()
        view.addSubview(roomTypeStackView)
        roomTypeStackView.axis = .vertical
        roomTypeStackView.tag = 1
        roomTypeStackView.translatesAutoresizingMaskIntoConstraints = false
        roomTypeStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 290).isActive = true
        roomTypeStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40.0).isActive = true
        roomTypeStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40.0).isActive = true
        
        roomTypeStackView.addArrangedSubview(roomTypeLabel)
        roomTypeStackView.addArrangedSubview(dropDownRoomTypeTextfield)
    }
    
    
    private func addDropdownBedTypeTextfield() {
        let lm = view.layoutMargins
        let height: CGFloat = 30.0
        let dropDownFrame = CGRect(x: lm.left, y: lm.top + 60, width: 296, height: height)
        
        dropDownBedTypeTextfield = DropDownTextField(frame: dropDownFrame, title: "Standard Bed", options: flavourOptions)
        dropDownBedTypeTextfield.delegate = self
        
        bedTypesLabel = UILabel()
        bedTypesLabel.text = "Bed Types"
        bedTypesLabel.font = .boldSystemFont(ofSize: 12)
        
        bedTypesStackView = UIStackView()
        view.addSubview(bedTypesStackView)
        bedTypesStackView.translatesAutoresizingMaskIntoConstraints = false
        bedTypesStackView.axis = .vertical
        bedTypesStackView.tag = 3
        bedTypesStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 390).isActive = true
        bedTypesStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        bedTypesStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        
        bedTypesStackView.addArrangedSubview(bedTypesLabel)
        bedTypesStackView.addArrangedSubview(dropDownBedTypeTextfield)
    
    }
    
    private func addAccomodationTexField() {
        accommodatStackView = UIStackView()
        
        accommodateLabel = UILabel()
        accommodateLabel.text = "Accomodates how many guest?"
        accommodateLabel.font = .boldSystemFont(ofSize: 12)
        
        accommodatesTextField = UITextField()
        accommodatesTextField.placeholder = "0"
        accommodatesTextField.borderStyle = .line
        
        view.addSubview(accommodatStackView)
        
        accommodatStackView.translatesAutoresizingMaskIntoConstraints = false
        accommodatStackView.axis = .vertical
        accommodatStackView.tag = 4
        accommodatStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 440).isActive = true
        accommodatStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        accommodatStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        accommodatStackView.addArrangedSubview(accommodateLabel)
        accommodatStackView.addArrangedSubview(accommodatesTextField)
        
       
    }
    
   
    
    // MARK: - Navigation

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
