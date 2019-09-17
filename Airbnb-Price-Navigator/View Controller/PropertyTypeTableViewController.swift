//
//  PropertyTypeTableViewController.swift
//  Airbnb-Price-Navigator
//
//  Created by Iyin Raphael on 9/17/19.
//  Copyright © 2019 Iyin Raphael. All rights reserved.
//

import UIKit

class PropertyTypeTableViewController: UIViewController {
    
    //MARK: Property 
    var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.frame = CGRect(x: 0.0, y: 0.0, width: 291, height: 295)
    
        let tableView = UITableView(frame: CGRect.zero)
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0.0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0.0).isActive = true
        self.tableView = tableView
    }
    
}
