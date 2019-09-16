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
    var bedorooms = UITextField()
    var bathrooms = UITextField()
    var bedTypes =  UITextField()
    var accommodates = UITextField()
    var submitButton = UIButton()
    
    var headerLabel = UILabel()
    var zipcodeLabel = UILabel()
    var propertyLabel = UILabel()
    var roomTypeLabel = UILabel()
    var bedroomsLabel = UILabel()
    var bathroomsLabel = UILabel()
    var bedTypesLabel = UILabel()
    var accommodateLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(stackview)
        stackview.axis = .vertical
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.spacing = 5
        stackview.distribution = .fillEqually
        stackview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        stackview.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50.0).isActive = true
        stackview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15.0).isActive = true
        stackview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15.0).isActive = true
        
        
        stackview.addArrangedSubview(headerLabel)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        stackview.addArrangedSubview(zipcodeStackView)
        zipcodeStackView.axis = .vertical
        zipcodeStackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        
       
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
  

}
