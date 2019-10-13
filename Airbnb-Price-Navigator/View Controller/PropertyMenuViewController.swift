//
//  MenuTableViewController.swift
//  Airbnb-Price-Navigator
//
//  Created by Iyin Raphael on 10/3/19.
//  Copyright © 2019 Iyin Raphael. All rights reserved.
//

import UIKit


class PropertyMenuViewController: UIViewController {
    
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
        cancelButton.topAnchor.constraint(equalTo: menuView.topAnchor, constant: 10).isActive = true
        cancelButton.leadingAnchor.constraint(equalTo: menuView.leadingAnchor, constant: 320).isActive = true
        
        stackView = UIStackView()
        menuView.addSubview(stackView)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 20.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: menuView.topAnchor, constant: 100).isActive = true
        stackView.leadingAnchor.constraint(equalTo: menuView.leadingAnchor, constant: 0).isActive = true
        stackView.trailingAnchor.constraint(equalTo: menuView.trailingAnchor, constant: 0).isActive = true
        
        homeButton = UIButton(type: .custom)
        homeButton.setTitle("Home", for: .normal)
        homeButton.setTitleColor(.black, for: .normal)
        homeButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        homeButton.addTarget(self, action: #selector(returnToHome), for: .touchUpInside)
        stackView.addArrangedSubview(homeButton)
        
        aboutButton = UIButton(type: .custom)
        aboutButton.setTitle("About", for: .normal)
        aboutButton.setTitleColor(.black, for: .normal)
        aboutButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        aboutButton.addTarget(self, action: #selector(whatIsAbout), for: .touchUpInside)
        stackView.addArrangedSubview(aboutButton)
        
        discoveriesButton = UIButton(type: .custom)
        discoveriesButton.setTitle("Discoveries", for: .normal)
        discoveriesButton.setTitleColor(.black, for: .normal)
        discoveriesButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        discoveriesButton.addTarget(self, action: #selector(whatToDiscover), for: .touchUpInside)
        stackView.addArrangedSubview(discoveriesButton)
        
        ourTeamButton = UIButton(type: .custom)
        ourTeamButton.setTitle("Our Team", for: .normal)
        ourTeamButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        ourTeamButton.setTitleColor(.black, for: .normal)
        ourTeamButton.addTarget(self, action: #selector(lookOurTeam), for: .touchUpInside)
        stackView.addArrangedSubview(ourTeamButton)

    }
    
    @objc func cancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func returnToHome() {
        let vc = PropertyViewController()
        present(UINavigationController(rootViewController: vc), animated: false, completion: nil)
        
    }
    
    @objc func whatIsAbout() {
        
    }
    
    @objc func whatToDiscover() {
        let vc = PropertyDiscoveriesTableViewController()
        present(UINavigationController(rootViewController: vc), animated: false, completion: nil)
    }
    
    @objc func lookOurTeam() {
        
    }
}


