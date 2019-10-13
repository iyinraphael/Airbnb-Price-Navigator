//
//  BaseNavViewController.swift
//  Airbnb-Price-Navigator
//
//  Created by Iyin Raphael on 10/4/19.
//  Copyright © 2019 Iyin Raphael. All rights reserved.
//

import UIKit


class PropertyBaseNavViewController: UIViewController {
    
    var menuBar: UIBarButtonItem!
    var logoButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        menuBar = UIBarButtonItem()
        menuBar.image = UIImage(named: "menu-bar")
        menuBar.target = self
        menuBar.action = #selector(showMenuBar)
        menuBar.tintColor = .black
        
        logoButton = UIBarButtonItem()
        logoButton.image = UIImage(named: "globe")?.withRenderingMode(.alwaysOriginal)
        logoButton.imageInsets = .init(top: -5, left: -5, bottom: -5, right: 5)
        
        navigationItem.rightBarButtonItem = menuBar
        navigationItem.leftBarButtonItem = logoButton
        navigationItem.title = "Airbnb Price Navigator"
    }

    @objc func showMenuBar() {
        let vc  = PropertyMenuViewController()
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
    
    }
    
}

extension UITextField {
    
   
    
}
