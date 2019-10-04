//
//  MenuTableViewController.swift
//  Airbnb-Price-Navigator
//
//  Created by Iyin Raphael on 10/3/19.
//  Copyright © 2019 Iyin Raphael. All rights reserved.
//

import UIKit


class MenuTableViewController: UIViewController {
    
    //MARK:- PROPERTIES
    var menuView: UIView!
    var stackView: UIStackView!
    var homeButton: UIButton!
    var aboutButton: UIButton!
    var discoveriesButton: UIButton!
    var ourTeamButton: UIButton!
    var cancelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuView = UIView()
        menuView.backgroundColor = .white
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.addSubview(menuView)
        menuView.translatesAutoresizingMaskIntoConstraints = false
        menuView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        menuView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        menuView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        menuView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -400).isActive = true
        
        cancelButton = UIButton(type: .custom)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "cancel")
        menuView.addSubview(cancelButton)
        cancelButton.setImage(image, for: .normal)
        cancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        cancelButton.topAnchor.constraint(equalTo: menuView.topAnchor, constant: 20).isActive = true
        cancelButton.leadingAnchor.constraint(equalTo: menuView.leadingAnchor, constant: 320).isActive = true
    }
    
    @objc func cancel() {
        self.dismiss(animated: true, completion: nil)
    }
}


